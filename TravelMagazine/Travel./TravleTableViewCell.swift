//
//  TravleTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

import Kingfisher

class TravleTableViewCell: UITableViewCell {
    
    @IBOutlet var travelTitleLabel: UILabel!
    @IBOutlet var travelSubTitleLabel: UILabel!
    @IBOutlet var travelStackView: UIStackView!
    @IBOutlet var travelImageView: UIImageView!
    @IBOutlet var heartButton: UIButton!
    
    @IBOutlet var starImageList: [UIImageView]!
    
    
    @IBOutlet var stackLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(data: Travel, like: Bool) {
        travelTitleLabel.text = data.title
        travelTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        travelSubTitleLabel.text = data.description
        travelSubTitleLabel.textColor = .darkGray
        travelSubTitleLabel.numberOfLines = 0
        travelSubTitleLabel.font = .systemFont(ofSize: 14)
        
        paintStarPoint(point: data.grade!, starImageList: starImageList)
        starImageList.forEach{$0.tintColor = .orange}
        
        stackLabel.text = data.subTitleDescription
        stackLabel.textColor = .lightGray
        stackLabel.font = .systemFont(ofSize: 13)
        
        travelImageView.contentMode = .scaleToFill
        let url = URL(string: data.travel_image ?? "")
        let processor = DownsamplingImageProcessor(size: travelImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 5)
        travelImageView.kf.indicatorType = .activity
        travelImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage])
        
        heartButton.tintColor = .red
        // heartButton bool check
        if like {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    

}

