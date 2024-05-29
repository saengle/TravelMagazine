//
//  RestauranctViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var segmentFilteredCity: [City] = []
    var wholeFilteredCity: [City] = []
    
    @IBOutlet var citySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let cityXib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register( cityXib, forCellReuseIdentifier: "CityTableViewCell")
        tableView.rowHeight = 150
        segmentFilteredCity = CityInfo.city
    }
    
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        segmentFilteredCity = []
        switch sender.selectedSegmentIndex {
        case 0:
            segmentFilteredCity.append(contentsOf: CityInfo.city)
        case 1:
            segmentFilteredCity.append(contentsOf: CityInfo.city.filter{$0.domestic_travel == true})
        case 2:
            segmentFilteredCity.append(contentsOf: CityInfo.city.filter{$0.domestic_travel == false})
        default:
            print("segment has an Error")
        }
        tableView.reloadData()
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        segmentFilteredCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        
        cell.configureCityCell(data: segmentFilteredCity[indexPath.row])
        
        return cell
    }
}


