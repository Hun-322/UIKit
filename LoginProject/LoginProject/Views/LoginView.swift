//
//  LoginView.swift
//  LoginProject
//
//  Created by KSH on 2022/11/21.
//

import UIKit

class LoginView: UIView {
    
    // 클로저의 실행문의 형태로 속성을 만드는 코드
    // MARK: - 이메일 입력하는 텍스트 뷰
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField) // 하위 뷰 추가 - 즉, 가장 밑에 있는 뷰에 emailTextField를 올린다.
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    // "이메일" 또는 "전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48 // 높이 설정
        tf.backgroundColor = .clear //투명
        tf.textColor = .white // 텍스트 컬러 설정
        tf.tintColor = .white // 틴트 컬러 설정
        tf.autocapitalizationType = .none // 시작 글자 대문자로 바꾸는 설정 (자동 대문자 처리에 대한 옵션)
        tf.autocorrectionType = .no // 자동으로 틀린글자 체크해주는 설정 자동 (교정 작동에 대한 옵션)
        tf.spellCheckingType = .no // 문자 또는 문장의 스펠링 처리에 대해서 교정해주는 옵션
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드텍스트필드의 안내문구
    private var passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font =  UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .darkGray
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true // 입력된 값 복사가 불가능 하고, 텍스트 입력이 들어오면 바로 이전 문자값은 hide 상태(*) 설정
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal) // 타이틀
        button.setTitleColor(#colorLiteral(red: 0.8374180918, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal) // 색깔설정
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light) // 크기
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    } ()
    
    // MARK: - 로그인버튼
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 3 // 선 너비
        button.layer.borderColor = UIColor.darkGray.cgColor // 선 색깔
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false // 버튼 동작 여부
        //        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18
        st.axis = .vertical // 어떻게 묶을껀지
        st.distribution = .fillEqually // 분배를 어떻게 할지
        st.alignment = .fill // 어떻게 정렬할것인지
        return st
    }()
    
    // 비밀번호 재설정 버튼
    lazy var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.07450980392, blue: 0.07450980392, alpha: 1)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func addViews() {
        [stackView, passwordResetButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        emailInfoLabelConstraints()
        emailTextFieldConstraints()
        passwordInfoLabelConstraints()
        passwordTextFieldConstraints()
        passwordSecureButtonConstraints()
        stackViewConstraints()
        passwordResetButtonConstraints()
    }
    
    private func emailInfoLabelConstraints() {
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            emailInfoLabelCenterYConstraint
        ])
    }
    
    private func emailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8)
        ])
    }
    
    private func passwordInfoLabelConstraints() {
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            passwordInfoLabelCenterYConstraint
        ])
    }
    
    private func passwordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8)
        ])
        
    }
    
    private func passwordSecureButtonConstraints() {
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8)
        ])
        
    }
    
    private func stackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36)
        ])
    }
    
    private func passwordResetButtonConstraints() {
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
        ])
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
    
    // MARK: - 비밀번호 가리기 모드 켜고 끄기
    @objc private func passwordSecureModeSetting() {
        // 이미 텍스트필드에 내장되어 있는 기능
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

extension LoginView: UITextFieldDelegate {
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // 텍스트필드 편집 종료되면 백그라운드 색 변경 (글자가 한개도 입력 안되었을때는 되돌리기)
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // 엔터 누르면 일단 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


