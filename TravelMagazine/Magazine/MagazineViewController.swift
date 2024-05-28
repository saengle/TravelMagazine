//
//  MagazineViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit
import Kingfisher

class MagazineViewController: UITableViewController {
    
    
    let magazineInfo = MagazineInfo()
    
    @IBOutlet var mainTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineControllerTableViewCell", for: indexPath) as? MagazineControllerTableViewCell else { return UITableViewCell()}
        let row = indexPath.row
        
        // Cell Image
        cell.magazineImageView.contentMode = .scaleToFill
        let url = URL(string: magazineInfo.magazine[row].photo_image)
        // image sampling process
        let processor = DownsamplingImageProcessor(size: cell.magazineImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        // 이미지 준비 될 때 까지 인디케이터 작동
//        cell.magazineImageView.backgroundColor = .black
        cell.magazineImageView.kf.indicatorType = .activity
        cell.magazineImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        // cell main title
        cell.titleLabel.text = magazineInfo.magazine[row].title
        
        
        // cell subtitle
        cell.subtitleLabel.text = magazineInfo.magazine[row].subtitle
    
            // date format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        if let date = formatter.date(from: magazineInfo.magazine[row].date) {
            formatter.dateFormat = "yy년 MM월 dd일"
            let convertedStr = formatter.string(from: date)
            cell.dateLabel.text = convertedStr
        } else {
            print("failed formatting date")
        }
       
        return cell
    }
}

extension MagazineViewController {
    private func setUI() {
        // 임시로 설정할 높이
//        self.tableView.estimatedRowHeight =
        self.tableView.rowHeight = UITableView.automaticDimension
        self.mainTitleLabel.text = "Travel"
        
    }
}
