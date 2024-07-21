//
//  ChattingVIewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/3/24.
//

import UIKit

import SnapKit

class ChattingViewController: UIViewController {
    
    @IBOutlet var chatTextField: UITextField!
    
    let chatList = mockChatList
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
    
    var dataSource: UICollectionViewDiffableDataSource<Int, ChatRoom>!
    
    private let cvLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        updateSnapshot()
    }
    
}

extension ChattingViewController {
    private func configureDataSource() {
        //cell register 대신에 registration 을 사용.
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>! // realm 처럼 암묵적으로 맞으니까 걍 들어가셈 하고 ! 사용 ...

        registration = UICollectionView.CellRegistration { cell, indexPath, chatRoom in
            // collectionView systemCell
            
            // 각각의 셀에 대한 설정 = 컨텐트컨피겨레이션
            var content = UIListContentConfiguration.sidebarCell()
            content.text = chatRoom.chatroomName
            content.secondaryText = chatRoom.chatList.last?.message
            content.prefersSideBySideTextAndSecondaryText = true
            content.image = UIImage(named: chatRoom.chatroomImage.first!)
            content.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            content.imageProperties.cornerRadius = 30
            content.imageToTextPadding = 16
            cell.contentConfiguration = content
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in // cellForItemAt 역할을 대신 해줌
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    private func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int, ChatRoom>() // cell 몇개 만들건데 ? 또 뭐 알려줄건데?
        snapShot.appendSections([0]) //
        snapShot.appendItems(chatList, toSection: 0) // 리스트 배열을 0 섹션에 추가
        dataSource.apply(snapShot) // reloadData
    }
}


extension ChattingViewController {
    private func configureUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(chatTextField.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
            
        }
        chatTextField.placeholder = "친구 이름을 검색하세요"
        chatTextField.backgroundColor = .systemGray6
        
    }
}
