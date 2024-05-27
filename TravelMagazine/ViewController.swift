//
//  ViewController.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/25/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func alertAction() {
//        //1. alert 생성
//        let alert = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
//        //2. action 선언 필요시 handler 사용.
//        let <#T##UIAlertAction#> = UIAlertAction(title: <#T##String?#>, style: <#T##UIAlertAction.Style#>)
//        let <#T##UIAlertAction#> = UIAlertAction(title: <#T##String?#>, style: <#T##UIAlertAction.Style#>, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
//        //3. alert에 action 등록
//        alert.addAction(<#T##UIAlertAction#>)
//        //4. 띄우기
//        present(alert, animated: <#T##Bool#>)
//    }
}
