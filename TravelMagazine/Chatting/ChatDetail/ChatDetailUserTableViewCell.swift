//
//  ChatDetailUserTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/4/24.
//

import UIKit

class ChatDetailUserTableViewCell: UITableViewCell {

    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let chatContentLabel = UILabel()
    let timeLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}


extension ChatDetailUserTableViewCell {
    func configureUI(user: User) {
        setConstraints(user: user)
        
    }
    
    private func setConstraints(user: User) {
        switch user {
        case .user:
            print("\(user)가 나다")
        default:
            print("\(user)가 남이다")
        }
        
    }
    
    private func setMyCaseConstraints() {
        
    }
    
    private func setOtherCaseConstraints() {
        
    }
}
