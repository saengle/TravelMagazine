//
//  MagazineModel.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import Foundation

struct Magazine {
    let title: String
    let subtitle: String
    let photo_image: String
    let date: String
    let link : String
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        if let myDate = formatter.date(from: date) {
            formatter.dateFormat = "yy년 MM월 dd일"
            let convertedStr = formatter.string(from: myDate)
            return convertedStr
        } else {
            return ""
        }
    }
}

