//
//  MapCollectionViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/31/24.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MapCollectionViewCell.self)
    
    @IBOutlet var myButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        myButton.tintColor = .black
        myButton.setTitle("왜", for: .normal)
        myButton.backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
