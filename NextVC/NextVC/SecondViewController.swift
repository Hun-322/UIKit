//
//  SecondViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    var sommString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainLabel.text = sommString
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // 전 화면으로 돌아가는 메서드
        dismiss(animated: true)
    }
    
}






