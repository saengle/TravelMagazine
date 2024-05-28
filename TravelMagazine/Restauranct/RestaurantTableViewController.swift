//
//  RestaurantTableViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/26/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantList = RestaurantList()
    var likeList: Array<Bool> = []
    var searchedList: [Restaurant] = []
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLikeList()
        setUI()
        tableView.rowHeight = 167
        searchTextFieldAddTarget(textField: searchTextField)
        searchRestaurant(keyWord: "")
        hideKeyboardWhenTappedAround()
    }
}

extension RestaurantTableViewController {
    
    private func makeLikeList() {
        for _ in 0...restaurantList.restaurantArray.count{
            likeList.append(false)
        }
    }
    
    private func setUI() {
        mainTitleLabel.text = "식당 예약"
        mainTitleLabel.font = .boldSystemFont(ofSize: 20)
        searchTextField.backgroundColor = .systemGray6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        // Whole cell's heartButton addTarget & add tag
        cell.heartButton.tag = indexPath.row
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        // configure Cell
        cell.configureRestauranctCell(searchedList[indexPath.row], heart: likeList[indexPath.row])
        
        return cell
    }
    
    private func searchTextFieldAddTarget(textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(keyboardDismiss), for: .editingDidEndOnExit)
    }
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
    
    @objc func textFieldEditingChanged(textField: UITextField) {
        guard let text = textField.text else {
            return print("오류가 발생했습니다.")
        }
        if text == " " {
            textField.text = ""
        }
        searchRestaurant(keyWord: text)
    }
    
    private func searchRestaurant(keyWord: String) {
        // clear searchedList before search
        if keyWord != "" {
            self.searchedList.removeAll()
        } else {
            self.searchedList.removeAll()
            searchedList.append(contentsOf: restaurantList.restaurantArray)
        }
        
        searchedList.append(contentsOf: restaurantList.restaurantArray.filter{$0.category.contains(keyWord) || $0.name.contains(keyWord)})
        
        self.tableView.reloadData()
    }
    
    @objc private func heartButtonTapped(button: UIButton) {
        likeList[button.tag].toggle()
        self.tableView.reloadRows(at: [IndexPath(row: button.tag, section: 0)], with: .automatic)
    }
}
