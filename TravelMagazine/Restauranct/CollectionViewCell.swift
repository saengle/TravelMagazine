//
//  CollectionViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/31/24.
//

import UIKit

import SnapKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CollectionViewCell.self)
    
    let myButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
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

extension CollectionViewCell {
    
    func setConstraints() {
        
        myButton.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalToSuperview()
            
        }
    }
}
