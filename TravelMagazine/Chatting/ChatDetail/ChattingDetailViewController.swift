//
//  ChattingDetailViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/3/24.
//

import UIKit

class ChattingDetailViewController: UIViewController {
    var chat: [ChatRoom] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        navigationController?.title = chat.first?.chatroomName // 옵셔널체크
        print(chat.first?.chatroomName)
        tableView.backgroundColor = .cyan
        textField.placeholder = "메세지를 입력하세요"
    }
    
}

extension ChattingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = chat.first?.chatList.count {
            return count
        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailUserTableViewCell.identifier, for: indexPath) as? ChatDetailUserTableViewCell else { return UITableViewCell() }
        
        // if let 아래 옵셔널 제거
        cell.configureUI(user: chat.first!.chatList[indexPath.row].user)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        tableView.
//    }
    
    
    
}
