//
//  MagazineControllerTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit

class MagazineControllerTableViewCell: UITableViewCell {

    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
