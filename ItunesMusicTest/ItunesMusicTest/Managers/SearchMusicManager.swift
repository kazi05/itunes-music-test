//
//  SearchMusicManager.swift
//  ItunesMusicTest
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "https://itunes.apple.com/"

class SearchMusicManager {
    
    static let shared = SearchMusicManager()
    private init() {}
    
    private let searchURL = baseURL + "search"
    
    func searchMusic(by artist: String?, completion: @escaping ([Music])-> Void) {
        let params = ["term": artist ?? ""]
        Alamofire.request(searchURL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (response) in
            print(response.request)
            switch response.result {
            case .success(let data):
                do {
//                    let musics = try JSONDecoder().decode([Music].self, from: data as! Data)
//                    print(musics)
//                    completion(musics)
                    print(data)
                }catch {
                    print("Error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
