//
//  UITabelViewCell+Extension.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/29/24.
//

import UIKit

extension UIView {
    func paintStarPoint (point: Double, starImageList: [UIImageView]) {
        starImageList.forEach{$0.image = UIImage(systemName: "star")}
        switch point {
        case 0.5..<1.0:
            starImageList[0].image = UIImage(systemName: "star.fill.left")
        case 1.0..<1.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
        case 1.5..<2:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill.left")
        case 2..<2.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
        case 2.5..<3:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill.left")
        case 3..<3.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
        case 3.5..<4:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
            starImageList[3].image = UIImage(systemName: "star.fill.left")
        case 4..<4.5:
            starImageList[0].image = UIImage(systemName: "star.fill")
            starImageList[1].image = UIImage(systemName: "star.fill")
            starImageList[2].image = UIImage(systemName: "star.fill")
            starImageList[3].image = UIImage(systemName: "star.fill")
        case 4.5..<5:
            starImageList.forEach{$0.image = UIImage(systemName: "star.fill")}
            starImageList[4].image = UIImage(systemName: "star.fill.left")
        case 5:
            starImageList.forEach{$0.image = UIImage(systemName: "star.fill")}
        default:
            print("오류 발생")
        }
    }
}
