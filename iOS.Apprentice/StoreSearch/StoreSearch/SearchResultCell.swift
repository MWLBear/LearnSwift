//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by admin on 2021/4/12.
//

import UIKit

class SearchResultCell: UITableViewCell {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var downloadTask: URLSessionDownloadTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        let seclectedView = UIView(frame: .zero)
        seclectedView.backgroundColor = UIColor(red: 20/255,
                                                green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = seclectedView
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        print("prepareForReuse")
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    func configure(for result: SearchResult) {
        nameLabel.text = result.name
        if result.artisit.isEmpty {
            artistNameLabel.text = NSLocalizedString("Unknown", comment: "Artist name: Unknown")
                
        }else {
            artistNameLabel.text = String(format: NSLocalizedString("ARTIST_NAME_LABEL_FORMAT", comment: "Format for artist name"), result.artisit, result.type)
        }
        artworkImageView.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: result.imageSmall) {
            downloadTask = artworkImageView.loadImage(url: smallURL)
        }
    }
}
