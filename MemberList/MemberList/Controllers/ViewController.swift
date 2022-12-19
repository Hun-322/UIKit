//
//  ViewController.swift
//  MemberList
//
//  Created by KSH on 2022/12/09.
//

import UIKit

final class ViewController: UIViewController {

    // 테이블뷰
    private let tableView = UITableView()
    
    //MARK: - 관리 모델 선언
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var memberListManager = MemberListManager()
    
    // 네비바안에 버튼
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupDatas()
        setupTableView()
        setupNaviBar()
        setupTableViewConstraints()
    }
    
    // 델리게이트가 아닌 방식으로 구현할때는 화면 리프레시⭐️
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // 유저 정보가 업데이트되면 tableView도 새로고침
//        tableView.reloadData()
//    }
    
    // 네이게이션바 설정
    func setupNaviBar() {
        title = "회원 목록"
        
        // 네비게이션바 설정관련
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 오른쪽 상단 버튼 설정
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    //MARK: - 테이블뷰 셋팅
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 60
        
        // 셀의 등록⭐️ (타입인스턴스 - 메타타입)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    func setupDatas() {
        memberListManager.makeMembersListDatas() // 일반적으로 서버에 요청해서 데이터 받기
    }
    
    //MARK: - 오토레이아웃 셋팅
    
    // 테이블뷰의 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    // 멤버를 추가하기 위한 다음 화면으로 이동 메서드
    @objc func plusButtonTapped() {
        // 다음화면으로 이동 (멤버는 전달하지 않음)
        let detailVC = DetailViewController()
        
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
//        detailVC.delegate = self
        
        // 화면이동
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

//MARK: - 테이블뷰 데이터 소스 구현

extension ViewController: UITableViewDataSource {
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        // MyTableViewCell에 속성 감시자를 생성 했기때문에 memberListManager[indexPath.row] 데이터만 주면된다.
        // 셀에다가 멤버를 전달 (멤버만 전달하면, 화면에 표시하도록 구현⭐️ 셀에서 didSet으로)
        cell.member = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
//        cell.mainImageView.image = memberListManager[indexPath.row].memberImage
//        cell.memberNameLabel.text = memberListManager[indexPath.row].name
//        cell.addressLabel.text = memberListManager[indexPath.row].address
//        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

//MARK: - 테이블뷰 델리게이트 구현 (셀이 선택되었을때)

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 다음화면으로 넘어가는 코드
        let detailVC = DetailViewController()
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
        detailVC.delegate = self
        
        // 다음 화면에 멤버를 전달
        let array = memberListManager.getMembersList()
        detailVC.member = array[indexPath.row]
        
        // 화면이동
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - 멤버를 추가하거나, 업데이트에 대한 델리게이트 구현

extension ViewController: MemberDelegate {
    // 멤버가 추가되면 실행할 메서드 구현
    func addNewMember(_ member: Member) {
        // 모델에 멤버 추가
        memberListManager.makeNewMember(member)
        // TableView 다시 로드 (다시 그리기)
        tableView.reloadData()
    }
    
    // 멤버의 정보가 업데이트 되면 실행할 메서드 구현
    func update(index: Int, _ member: Member) {
        print("업데이트")
        // 모델에 멤버 정보 업데이트
        memberListManager.updateMemberInfo(index: index, member)
        // TableView 다시 로드 (다시 그리기)
        tableView.reloadData()
    }
}

