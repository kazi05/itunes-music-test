//
//  SearchMusicManager.swift
//  ItunesMusicTest
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let baseURL = "https://itunes.apple.com/"

class SearchMusicManager {
    
    static let shared = SearchMusicManager()
    private init() {}
    
    private let searchURL = baseURL + "search"
    
    
    //MARK: Get music list
    func searchMusic(by artist: String?, completion: @escaping (Music)-> Void) {
        let artistFullName = artist?.replacingOccurrences(of: "+", with: " ")
        let params = ["term": artistFullName ?? ""]
        Alamofire.request(searchURL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                guard let results = jsonData["results"].array else { return }
                results.forEach({ (music) in
                    let result = Music(music)
                    completion(result)
                })
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Get album image
    func downloadAlbumImage(url: String?, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url ?? "").responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
