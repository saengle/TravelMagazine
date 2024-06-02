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
    var searchedCity: [City] = []
    var wholeFilteredCity: [City] = []
    lazy var resultList: [City] = []
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var citySegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addTargets()
        let cityXib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register( cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.rowHeight = 150
        segmentFilteredCity = CityInfo.city
        searchedCity = CityInfo.city
        wholeFilteredCity = CityInfo.city
    }
    
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        segmentFilteredCity.removeAll()
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
        wholeFilterdCityReload()
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wholeFilteredCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        
        cell.configureCityCell(data: wholeFilteredCity[indexPath.row])
        
        return cell
    }
}

extension CityViewController {
    private func addTargets() {
        cityTextField.addTarget(self, action: #selector(searchTextField), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEnd)
        cityTextField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    //editing changed
    @objc func searchTextField(sender: UITextField) {
        guard let keyWord = sender.text else {return}
        
        if keyWord.last == " " {
            sender.text?.popLast()
        }
        searchCity(keyWord: keyWord)
    }
    
    private func searchCity(keyWord: String) {
        searchedCity.removeAll()
        if keyWord.isEmpty {
            searchedCity.append(contentsOf: CityInfo.city)
        } else {
            searchedCity.append(contentsOf: CityInfo.city.filter{$0.city_name.contains(keyWord) || $0.city_explain.contains(keyWord) || $0.city_english_name.lowercased().contains(keyWord.lowercased())})
        }
        wholeFilterdCityReload()
        
    }
    
    private func wholeFilterdCityReload() {
//        print(wholeFilteredCity)
        wholeFilteredCity.removeAll()
        wholeFilteredCity.append(contentsOf: Array(Set(searchedCity).intersection(Set(segmentFilteredCity))))
        tableView.reloadData()
    }
}
