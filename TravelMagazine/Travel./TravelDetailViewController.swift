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
    var like = false
   
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var starImageCollection: [UIImageView]!
    @IBOutlet var heartButton: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.view.paintStarPoint(point: travel[0].grade ?? 0, starImageList: starImageCollection)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(heartButtonClicked))
        heartButton.isUserInteractionEnabled = true
        heartButton.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension TravelDetailViewController{
    func configureUI() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = travel[0].title
        imageView.contentMode = .scaleToFill
        guard let imageUrl = travel.first?.travel_image else {return}
        guard let url = URL(string: imageUrl) else {return}
        imageView.kf.setImage(with: url)
        starImageCollection.forEach{$0.tintColor = .orange}
        descriptionLabel.text = travel[0].description
        saveLabel.text = travel[0].subTitleDescription
       
    }
    
    @objc func heartButtonClicked() {
        like.toggle()
        if like {
            heartButton.image = UIImage(systemName: "heart.fill")
        } else {
            heartButton.image = UIImage(systemName: "heart")
        }
    }
}
