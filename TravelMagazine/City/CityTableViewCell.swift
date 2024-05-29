//
//  CityTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/29/24.
//

import UIKit

import Kingfisher

class CityTableViewCell: UITableViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityNameLabel.numberOfLines = 1
        
        cityExplainLabel.numberOfLines = 1
//        self.radi
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    func configureCityCell(data: City) {
        cityNameLabel.text = "\(data.city_name) | \(data.city_english_name)"
        
        cityExplainLabel.text = data.city_explain
       
        cityImageView.contentMode = .scaleAspectFill
        let url = URL(string: data.city_image)
        let processor = DownsamplingImageProcessor(size: cityImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20, roundingCorners: [.topLeft, .bottomRight], backgroundColor: .white)
        cityImageView.kf.indicatorType = .activity
        cityImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage])
    }
}
