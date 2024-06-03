//
//  ChattingVIewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/3/24.
//

import UIKit

class ChattingViewController: UIViewController {
    
    @IBOutlet var chatTextField: UITextField!
    @IBOutlet var chatTableView: UITableView!
    
    let chatList = mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print(chatList.count)
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMainTableViewCell.identifier, for: indexPath) as? ChatMainTableViewCell else { return UITableViewCell()}
        cell.configureCell(data: chatList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ChattingDetailView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ChattingDetailViewController.identifier) as! ChattingDetailViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChattingViewController {
    private func configureUI() {
        chatTableView.rowHeight = 70
        navigationController?.title = "Travel Talk"
        let xib = UINib(nibName: ChatMainTableViewCell.identifier, bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: ChatMainTableViewCell.identifier)
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorColor = .clear
        
        chatTextField.placeholder = "친구 이름을 검색하세요"
        chatTextField.backgroundColor = .systemGray6
        
    }
}
