//
//  AdViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {
    var adTravel: Travel?
    @IBOutlet var adLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adLabel.font = .systemFont(ofSize: 17)
        adLabel.numberOfLines = 0
        adLabel.textAlignment = .center
        navigationController?.isNavigationBarHidden = false
        if let text = adTravel?.title {
            adLabel.text = text
        }
    }
    @IBAction func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
