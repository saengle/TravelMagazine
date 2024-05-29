//
//  TravelDetailViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/29/24.
//

import UIKit

import Kingfisher

class TravelDetailViewController: UIViewController {
    
    var travel: [Travel] = []
    
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension TravelDetailViewController{
    func setUI() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = travel[0].title
        imageView.contentMode = .scaleToFill
        guard let imageUrl = travel.first?.travel_image else {return}
        guard let url = URL(string: imageUrl) else {return}
        imageView.kf.setImage(with: url)
    }
}
