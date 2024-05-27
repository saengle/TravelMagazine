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
    var likeList: Array<Bool> = []
    var isSearching = false
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        
        let list = searchedList[indexPath.row]
        
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
            isSearching = true
            self.searchedList.removeAll()
        } else {
            isSearching = false
            self.searchedList.removeAll()
            searchedList.append(contentsOf: restaurantList.restaurantArray)
        }
        // search using category
        for element in restaurantList.restaurantArray {
            if keyWord == element.category {
                searchedList.append(element)
            }
        }
        
        for element in restaurantList.restaurantArray {
            if element.name.contains(keyWord) {
                searchedList.append(element)
            }
        }
        // dedupe
        searchedList = Array(Set(searchedList))
        
        self.tableView.reloadData()
    }
    
    @objc private func heartButtonTapped(button: UIButton) {
        likeList[button.tag].toggle()
        self.tableView.reloadRows(at: [IndexPath(row: button.tag, section: 0)], with: .automatic)
    }
}
