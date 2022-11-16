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
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동 (추천!)
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.sommString = "아빠상어"
        // SecondViewController가 생성되는 순간과 stroyboard가 생성되는 순간이 다른데 , 두개가 연결이 되기전에 접근이되서 오류가난다.
        // secondVC.mainLabel.text = "아빠상어"
        present(secondVC, animated: true)
        
        
    }
    
    
    
    // 3) 스토리보드에서의 화면 이동(간접 세그웨이)
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        // storyboardWithSegueButtonTapped가 눌렸을때 performSegue는 실행만 하는것
        // 데이터를 전달을 할려면 prepare메서드를 구현 해줘야한다.
        // performSegue를 실행을 시킴으로써 그 segue 객체를 활성화 시키는것
        // 그리고 performSegue 내부에서 prepare를 실행시킴
        performSegue(withIdentifier: "toThirdVC", sender: self)
        
        
    }
    // segue에 데이터 전달 방법
    // segue는 전달된 Parameter의 이름
    // 즉 segue는 stroyBoard Main에 보면 VC랑 ThirdVC랑 연결되있는 선이다. == 화면이동을 관리하는 객체
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as! ThirdViewController
            // 데이터 전달
            thirdVC.someString = "엄마상어"
        }
        if segue.identifier == "toFourthVC" {
            let fourVC =  segue.destination as! FourthViewController
            fourVC.someString = "마지막 데이터 전달 완료"
        }
    }
    // 직접적으로 버튼에서 VC로 세그웨이를 연결했을때 조건을 걸어줄 수 있는 메서드
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        true
    }
    
    
    
}

