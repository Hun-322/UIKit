//
//  MyTableViewCell.swift
//  MemberList
//
//  Created by KSH on 2022/12/09.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // 속성 감시자
    var member: Member? {
        didSet {
            guard var member = member else { return }
            mainImageView.image = member.memberImage
            memberNameLabel.text = member.name
            addressLabel.text = member.address
        }
    }
    
    //MARK: - UI구현
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }
    
    func setupStackView() {
        self.addSubview(mainImageView)
        
        // 셀 위에 스택뷰 올리기
        self.addSubview(stackView)
        
        // 스택뷰 위에 뷰드 올리기
        stackView.addArrangedSubview(memberNameLabel)
        stackView.addArrangedSubview(addressLabel)
    }
    
    // 필수 생성자 구현 ( 왜 구현 해야함? -> 내가 지정 생성자(override init)를 재정의를 했기 때문에 -> 지정생성자를 재정의를 한다는것은 내가 어떤 저장속성을 만들 수도 있는데, 이때 저장속성을 세팅을 해주기 위해서 지정생성자를 재정의를 해서 구현을하는데, 이런 경우는 필수 생성자가 상속이 안됨! 그래서 필수 생성자를 !필수적으로! 구현해야함
    // apple 내부 매커니즘 상 필수 생성자가 필요하기 때문에 우리는 그걸 따라야한다!
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // StoryBoard로 앱을 만들때 viewDidLoad() 역할을 하는 생성자와 비슷한 함수
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    //MARK: - 오토레이아웃 셋팅
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    // view의 drawing cycle 참조 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainImageView.clipsToBounds = true
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 2
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 40),
            mainImageView.widthAnchor.constraint(equalToConstant: 40),
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            memberNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.mainImageView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor)
        ])
    }

}
