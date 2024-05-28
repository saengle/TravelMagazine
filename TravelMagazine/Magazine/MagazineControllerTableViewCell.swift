//
//  MagazineControllerTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit

import Kingfisher

class MagazineControllerTableViewCell: UITableViewCell {
    
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellUI()
        layoutSubviews()
        prepareForReuse()
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
        print(#function)
    }
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        magazineImageView.backgroundColor = .black
    }
    
    func configureMagazineCell(_ data: Magazine) {
        // Cell Image
        magazineImageView.contentMode = .scaleToFill
        let url = URL(string: data.photo_image)
        // image sampling process
        // 바운즈를 읽어오는 시기와 백그라운드 컬러를 칠하는 시기가 다르긴 할텐데 ... 언제지
        let processor = DownsamplingImageProcessor(size: magazineImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        print(#function, "지금 막 바운즈 읽어왔다?")
        magazineImageView.backgroundColor = .black
        // 이미지 준비 될 때 까지 인디케이터 작동
        //        cell.magazineImageView.backgroundColor = .black
        magazineImageView.kf.indicatorType = .activity
        magazineImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        //        프린트 지저분해서 재워둠
        //        {
        //            result in
        //            switch result {
        //            case .success(let value):
        //                print("Task done for: \(value.source.url?.absoluteString ?? "")")
        //            case .failure(let error):
        //                print("Job failed: \(error.localizedDescription)")
        //            }
        //        }
        
        // cell main title
        titleLabel.text = data.title
        
        // cell subtitle
        subtitleLabel.text = data.subtitle
        
        // Magazine model Computed Property
        dateLabel.text = data.formattedDate
    }
}
