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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if travelList[indexPath.row].ad {
            //        1. 스토리보드 가져오기
            let sb = UIStoryboard(name: "Ad", bundle: nil)
            //        2. 스토리보드 내 전환하고자 하는 화면 가져오기
            let vc = sb.instantiateViewController(withIdentifier: "AdViewController") as! AdViewController
            //        3. 화면 띄우기: 스토리보드에서 네비게이션 컨트롤러가 임베드 되어있지 않으면, push 안됨( navigationController?. 에서 네비컨트롤러 사용함.
            //        if navigationController != nil { 아래줄 코드와 같음 }
            present(vc, animated: true)
            // 옵셔널체이닝 처리가 되어있어서 네비게이션컨트롤러가 없을 시 클릭은 되지만 작동 X (꺼지지 않음)
        } else {
            //        1. 스토리보드 가져오기
            let sb = UIStoryboard(name: "TravelDetail", bundle: nil)
            //        2. 스토리보드 내 전환하고자 하는 화면 가져오기
            let vc = sb.instantiateViewController(withIdentifier: "TravelDetailViewController") as! TravelDetailViewController
            //        3. 화면 띄우기: 스토리보드에서 네비게이션 컨트롤러가 임베드 되어있지 않으면, push 안됨( navigationController?. 에서 네비컨트롤러 사용함.
            //        if navigationController != nil { 아래줄 코드와 같음 }
            navigationController?.pushViewController(vc, animated: true)
            // 옵셔널체이닝 처리가 되어있어서 네비게이션컨트롤러가 없을 시 클릭은 되지만 작동 X (꺼지지 않음)
            vc.travel.append(travelList[indexPath.row])
        }
    }
    
    @objc private func likeButtonTapped(button: UIButton) {
        travelLikeList[button.tag].toggle()
        self.tableView.reloadRows(at: [IndexPath(row: button.tag, section: 0)], with: .automatic)
    }
}

