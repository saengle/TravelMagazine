//
//  RestauranctViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let cityXib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register( cityXib, forCellReuseIdentifier: "CityTableViewCell")
        tableView.rowHeight = 150
    }
    
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CityInfo.city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        
        cell.configureCityCell(data: CityInfo.city[indexPath.row])
        
        return cell
    }
}


