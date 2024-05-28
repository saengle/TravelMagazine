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
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(data: Travel) {
        travelTitleLabel.text = data.title
        travelTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        travelSubTitleLabel.text = data.description
        travelSubTitleLabel.textColor = .darkGray
        travelSubTitleLabel.numberOfLines = 0
        travelSubTitleLabel.font = .systemFont(ofSize: 14)
        
        paintStarPoint(point: data.grade!)
        starImageList.forEach{$0.tintColor = .orange}
        
        stackLabel.text = "(\(data.grade ?? 0.0)) 저장 \(data.save ?? 0)"
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
        
        heartButton.tintColor = .white
    }
    
    private func paintStarPoint (point: Double) {
        starImageList.forEach{$0.image = UIImage(systemName: "star")}
        switch point {
        case 0.5..<1.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
        case 1.5..<2:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill.left")
        case 2..<2.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
        case 2.5..<3:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill.left")
        case 3..<3.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
        case 3.5..<4:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
            starImageList[3].image = UIImage(systemName: "star.fill.left")
        case 4..<4.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
            starImageList[3].image = UIImage(systemName: "star.fill")
        case 4.5..<5:
            starImageList.forEach{$0.image = UIImage(systemName: "star.fill")}
            starImageList[4].image = UIImage(systemName: "star.fill.left")
        default:
            print("별 그리기중 오류 발생")
        }
        
        
    }
}
