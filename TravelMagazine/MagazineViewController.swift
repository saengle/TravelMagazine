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
//        tableView.rowHeight =
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineInfo.magazine.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineControllerTableViewCell", for: indexPath) as? MagazineControllerTableViewCell else { return UITableViewCell()}
        let row = indexPath.row
        
        cell.titleLabel.text = magazineInfo.magazine[row].title
        
        cell.subtitleLabel.text = magazineInfo.magazine[row].subtitle
        
//        cell.magazineImageView.image =
//
//        cell.dateLabel.text = 
//        
        return cell
    }
}

extension MagazineViewController {
    private func setUI() {
        self.mainTitleLabel.text = "Travel"
        
        
    }
    
    
    
}
