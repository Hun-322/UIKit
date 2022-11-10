//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        let firstVC = FirstViewController()
        
        firstVC.someString = "아기상어"
        // 코드로 만들때만 가능 why? 스토리보드가 실행되는 매커니즘은 코드로된 VC를 메모리에 올리고 그다음 스토리보드를 올린 후 두개를 연결하는 과정을 거치는데
        // 스토리보드로 이 코드를 실행시키면 두개를(VC와 스토리보드) 연결하는 과정전에 코드가 실행되서 아직 메모리에 올라가지않았다고 오류가난다. 
        firstVC.mainLabel.text = "아기상어"
        
        // 다음 화면을 전체화면으로 변경
        firstVC.modalPresentationStyle = .fullScreen
        present(firstVC, animated: true, completion: nil)
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {

        
        
        
        
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        

        
        
        
        
    }
    

    
}

