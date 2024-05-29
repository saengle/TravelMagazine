//
//  TravelViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController {
    
    var travelList: [Travel] = TravelInfo().travel
    let adTabelViewCell = AdTableViewCell()
    var travelLikeList: Array<Bool> = []
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Travel"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .brown
        
        
        return view
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let travelXib = UINib(nibName: "TravleTableViewCell", bundle: nil)
        tableView.register( travelXib, forCellReuseIdentifier: "TravleTableViewCell")
        let adXib = UINib(nibName: "AdTableViewCell", bundle: nil)
        tableView.register( adXib, forCellReuseIdentifier: "AdTableViewCell")
        setUI()
        travelList.forEach{travelLikeList.append($0.like ?? false)}
       
    }
    
    private func setUI() {
        addTravelSubView()
        setTravelConstraints()
        
    }
    
    private func addTravelSubView() {
        view.addSubview(mainTitleLabel)
        view.addSubview(tableView)
    }
    private func setTravelConstraints() {
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainTitleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            mainTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.mainTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = travelList[indexPath.row]
        if data.ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
            cell.configureCell(data: data)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TravleTableViewCell", for: indexPath) as? TravleTableViewCell else { return UITableViewCell() }
            cell.configureCell(data: data, like: travelLikeList[indexPath.row])
            cell.heartButton.tag = indexPath.row
            cell.heartButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = travelList[indexPath.row].ad ? 70 : 130
        return CGFloat(cellHeight)
    }
    
    @objc private func likeButtonTapped(button: UIButton) {
        travelLikeList[button.tag].toggle()
        self.tableView.reloadRows(at: [IndexPath(row: button.tag, section: 0)], with: .automatic)
    }
}

