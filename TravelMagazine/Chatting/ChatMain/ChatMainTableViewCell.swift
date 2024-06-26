//
//  ChatMainTableViewCell.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/3/24.
//

import UIKit

import Kingfisher

class ChatMainTableViewCell: UITableViewCell {

    let chatList: [ChatRoom] = []
    
    @IBOutlet var chatRoomImageView: UIImageView!
    @IBOutlet var chatRoomIdLabel: UILabel!
    @IBOutlet var chatRoomDateLabel: UILabel!
    @IBOutlet var chatRoomContentLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    func configureCell(data: ChatRoom) {
        
        chatRoomImageView.layer.cornerRadius = 26
        chatRoomImageView.clipsToBounds = true
        chatRoomImageView.contentMode = .scaleAspectFit
        chatRoomImageView.image = UIImage(named: data.chatroomImage.first!)
        
        chatRoomIdLabel.text = data.chatroomName
        chatRoomIdLabel.font = .boldSystemFont(ofSize: 17)
        chatRoomIdLabel.textAlignment = .left
        
        chatRoomDateLabel.text = data.chatList.last?.date
        chatRoomDateLabel.font = .systemFont(ofSize: 12)
        chatRoomDateLabel.textAlignment = .right
        chatRoomDateLabel.textColor = .systemGray3
        
        
        chatRoomContentLabel.text = data.chatList.last?.message
        chatRoomContentLabel.font = .systemFont(ofSize: 14)
        chatRoomContentLabel.textColor = .systemGray
    }
}
//let chatroomId: Int //채팅방 고유 ID
//let chatroomImage: [String] //채팅방에 속한 유저 이미지
//let chatroomName: String //채팅방 이름
//var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
//ChatRoom(chatroomId: 1,
//         chatroomImage: [User.hue.profileImage, User.jack.profileImage, User.bran.profileImage, User.den.profileImage],
//         chatroomName: "영등포 멘토방",
//         chatList: [
//            Chat(user: .hue,
//                 date: "2024-06-12 21:30",
//                 message: "열심히 일 하시고 계시는거죠?"),
//            Chat(user: .bran,
//                 date: "2024-06-12 22:32",
//                 message: "영등포 캠퍼스 가고싶어요..."),
//            Chat(user: .jack,
//                 date: "2024-06-12 22:38",
//                 message: "화이팅!!"),
//            Chat(user: .den,
//                 date: "2024-06-12 23:42",
//                 message: "열심히 하고 있습니다!!"),
//         ]
//        ),
