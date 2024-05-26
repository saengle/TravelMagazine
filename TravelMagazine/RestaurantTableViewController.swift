//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/26/24.
//

import UIKit

import Kingfisher

class RestaurantTableViewController: UITableViewController {

    var restaurantList = RestaurantList()
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.rowHeight = 167
    }
    
}

extension RestaurantTableViewController {
    
    private func setUI() {
        mainTitleLabel.text = "식당 예약"
        mainTitleLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.restaurantArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        
        let list = restaurantList.restaurantArray[indexPath.row]
        
        cell.titleLabel.text = list.name
        cell.titleLabel.numberOfLines = 2
        // cell iamge
        cell.posterImageView.contentMode = .scaleToFill
        let url = URL(string: list.image)
        let processor = DownsamplingImageProcessor(size: cell.posterImageView.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 15)
        
        cell.posterImageView.kf.indicatorType = .activity
        cell.posterImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        cell.contentLabel.text = "\(list.price)원 \n\(list.category)"
        cell.contentLabel.numberOfLines = 2
        cell.contentLabel.textColor = .lightGray
        
        // heartButton bool check
        if likeList[indexPath.row] {
            cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.heartButton.tag = indexPath.row
        cell.heartButton.tintColor = .red
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        
        
        return cell
    }
    
}
