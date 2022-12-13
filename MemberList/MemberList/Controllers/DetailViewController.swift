//
//  DetailViewController.swift
//  MemberList
//
//  Created by KSH on 2022/12/13.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    var member: Member?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupButtonAction()
    }
    
    private func setupData() {
        detailView.member = member
    }
    
    // 뷰에있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        print("버튼 눌림")
    }
}
