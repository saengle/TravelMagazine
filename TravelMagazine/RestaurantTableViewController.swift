//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/26/24.
//

import UIKit

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
        
        
        
        
        return cell
    }
    
}
