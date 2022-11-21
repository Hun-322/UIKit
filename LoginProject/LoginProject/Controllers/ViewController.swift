//
//  ViewController.swift
//  LoginProject
//
//  Created by KSH on 2022/10/16.
//

import UIKit


// class는 구조체보다 느리게 동작한다.(table dispatch때문에) final을 붙혀서 더 이상 상속이 되지않도록 막으면서, 다이렉트 디스패치가 일어나도록 한다.
final class ViewController: UIViewController {
    
    private let loginView = LoginView()
    
    // viewDidLoad보다 먼저 실행되는 함수, 기본 view를 loginView로 변경
    override func loadView() {
        view = loginView
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    // 로그인 버튼 누르면 동작하는 함수
    @objc func loginButtonTapped() {
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
        print("로그인 버튼이 눌렸습니다.")
    }
    
    // 리셋버튼이 눌리면 동작하는 함수
    @objc func resetButtonTapped() {
        
        let alert = UIAlertController(title: "비밀번호 변경", message: "비밀번호를 변경 하시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인 완료")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("취소 완료")
        }
        alert .addAction(success)
        alert .addAction(cancel)
        
        // 다음 화면으로 넘어가는 메서드 (실제 띄우기)
        self.present(alert, animated: true, completion: nil)
    }
    
}

