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
    
    func searchMusic(by artist: String?, completion: @escaping ([Music])-> Void) {
        let artistFullName = artist?.replacingOccurrences(of: "+", with: " ")
        let params = ["term": artistFullName ?? ""]
        Alamofire.request(searchURL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            print(response.request)
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                print(jsonData)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
