//
//  RestauranctViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var citySegment: UISegmentedControl!
    
    let cityViewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        addTargets()
        let cityXib = UINib(nibName: "CityTableViewCell", bundle: nil)
        tableView.register( cityXib, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.rowHeight = 150
        bindData()
    }
    
    @IBAction func citySegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.cityViewModel.segmentInput.value = 0
        case 1:
            self.cityViewModel.segmentInput.value = 1
        case 2:
            self.cityViewModel.segmentInput.value = 2
        default:
            print("segment has an Error")
        }
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityViewModel.outputCities.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        
        cell.configureCityCell(data: cityViewModel.outputCities.value[indexPath.row])
        
        return cell
    }
}

extension CityViewController {
    private func bindData() {
        cityViewModel.outputCities.bind { value in
            self.tableView.reloadData()
        }
    }
    private func addTargets() {
        cityTextField.addTarget(self, action: #selector(searchTextField), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEnd)
        cityTextField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    //editing changed
    @objc func searchTextField(sender: UITextField) {
        guard let keyWord = sender.text else { return }
        
        if keyWord.last == " " {
            sender.text?.popLast()
        }
        
        self.cityViewModel.searchedInput.value = keyWord
    }
}
