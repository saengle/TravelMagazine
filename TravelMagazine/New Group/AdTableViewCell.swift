//
//  AdTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    
    let randomColorList = [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5861218572, green: 0.7041339278, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.680568397, blue: 0.9947488904, alpha: 1), #colorLiteral(red: 1, green: 0.8174908757, blue: 0.7006437182, alpha: 1), #colorLiteral(red: 0.393160373, green: 1, blue: 0.6794633269, alpha: 1)]
    @IBOutlet var adContentLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    @IBOutlet var adBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        adBackgroundView.backgroundColor = randomColorList[Int.random(in: 0...9)]
        
        adBackgroundView.layer.cornerRadius = 8
        adBackgroundView.layer.masksToBounds = true
    
        adContentLabel.font = .boldSystemFont(ofSize: 16)
        adContentLabel.numberOfLines = 0
        adContentLabel.text = "하와이가 가고 싶다고요 ? 저렴한 가격에 모십니다 델타항공"
        adLabel.layer.cornerRadius = 5
        adLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: Travel) {
        adContentLabel.text = data.title
        adContentLabel.font = .boldSystemFont(ofSize: 17)
        adContentLabel.numberOfLines = 2
    }
    
}
