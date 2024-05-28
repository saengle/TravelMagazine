//
//  RestaurantTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/26/24.
//

import UIKit

import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var heartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.numberOfLines = 0
        
        posterImageView.contentMode = .scaleToFill
        
        contentLabel.numberOfLines = 2
        contentLabel.textColor = .lightGray
        
        heartButton.tintColor = .red
    }
    //
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    func configureRestauranctCell(_ data: Restaurant, heart: Bool) {
        titleLabel.text = data.name
        
        let url = URL(string: data.image)
        let processor = DownsamplingImageProcessor(size: posterImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 15)
        
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage])
        
        contentLabel.text = "\(data.price)원 \n\(data.category)"
        
        // heartButton bool check
        if heart {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
}
