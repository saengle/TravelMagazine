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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.rowHeight = 50
        view.backgroundColor = .black
        
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension ChattingViewController {
    private func configureUI() {
        
    }
}
