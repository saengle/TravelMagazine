//
//  MagazineControllerTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit

class MagazineControllerTableViewCell: UITableViewCell {

    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 데이터와 관련 없는 셀에 직접 적용할 코드
    private func setCellUI() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = .lightGray
        
        // cell.dateLabel
        dateLabel.textAlignment = .right
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 9)
        
        magazineImageView.backgroundColor = .black
    }
    // 셀이 재사용 될 때 정해지지 않은 경우에 대한 리셋용
    override func prepareForReuse() {
        super.prepareForReuse()
        magazineImageView.backgroundColor = .black
    }
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        magazineImageView.backgroundColor = .black
    }
    
   
}
