//
//  MagazineViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit


class MagazineViewController: UITableViewController {
    
    
    let magazineInfo = MagazineInfo()
    
    @IBOutlet var mainTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MagazineInfo.magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineControllerTableViewCell", for: indexPath) as? MagazineControllerTableViewCell else { return UITableViewCell()}
        
        cell.configureMagazineCell(MagazineInfo.magazine[indexPath.row])
        
        return cell
    }
}

extension MagazineViewController {
    private func setUI() {
        // 임시로 설정할 높이
        //        self.tableView.estimatedRowHeight =
        // automaticDimension: cell의 크기가 내부 요인의 크기에 따라 변화함.
        self.tableView.rowHeight = UITableView.automaticDimension
        self.mainTitleLabel.text = "Travel"
    }
}
