//
//  MusicTableViewCell.swift
//  ItunesMusicTest
//
//  Created by Kazim Gajiev on 09/02/2019.
//  Copyright © 2019 Kazim Gajiev. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell, NibLoadable {
    
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var albumInageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(artistName: String?, and trackName: String?) {
        self.artistNameLabel.text = artistName
        self.trackNameLabel.text = trackName
    }
    
    func set(image imageURL: String?) {
        SearchMusicManager.shared.downloadAlbumImage(url: imageURL) { (image) in
            self.albumInageView.image = image
        }
    }
    
}
