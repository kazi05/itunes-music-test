//
//  MusicModel.swift
//  ItunesMusicTest
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Music {
    let artistName: String?
    let trackName: String?
    let albumImageURL: String?
    
    init(_ dict: JSON) {
        self.artistName = dict["artistName"].string
        self.trackName = dict["trackName"].string
        self.albumImageURL = dict["artworkUrl60"].string
    }
    
    init(artistName: String?, trackName: String?, imageURL: String?) {
        self.artistName = artistName
        self.trackName = trackName
        self.albumImageURL = imageURL
    }
}
