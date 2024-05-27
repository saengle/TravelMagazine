//
//  TravelViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/27/24.
//

import UIKit

class TravelViewController: UIViewController {
    
    let travelList = TravelInfo().travel
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    private func setUI() {}
    
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as? TravelTableViewCell else {return UITableViewCell()}
        
        
        return cell
    }
}

