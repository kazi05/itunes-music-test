//
//  ItunesMusicTestTests.swift
//  ItunesMusicTestTests
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import XCTest
@testable import ItunesMusicTest
@testable import SwiftyJSON

class ItunesMusicTestTests: XCTestCase {

    func testLoadImage() {
        let urlString = "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjwupiCt6_gAhVhl4sKHRfMDFAQjRx6BAgBEAU&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fnature%2F&psig=AOvVaw1aSVniMNThBXJwNfudxCZS&ust=1549828430870710"
        SearchMusicManager.shared.downloadAlbumImage(url: urlString) { (image) in
            XCTAssertNotNil(image)
        }
    }
    
    func testArtistName() {
        var musics: [Music] = []
        SearchMusicManager.shared.searchMusic(by: "Snoop Dog") { (music) in
            musics.append(music)
            let artistName = musics.filter{ $0.artistName == "Snoop Dog" }
            XCTAssertEqual(artistName[0].artistName, "Snoop Dog")
            XCTAssertGreaterThan(artistName.count, 0)
        }
    }
    
    

}
