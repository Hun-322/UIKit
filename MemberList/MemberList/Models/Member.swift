//
//  Member.swift
//  MemberList
//
//  Created by KSH on 2022/12/09.
//

import UIKit

// 간단한 데이터 모델들은 class보다 가벼운 struct로 많이 구현한다. (데이터와 관련된 Model)
struct Member {
    
    lazy var memberImage: UIImage? = {
        // 이름이 없다면, 기본 값으로 시스템 사람이미지 셋팅
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        // 해당이름으로된 이미지가 없다면, 시스템 사람이미지 셋팅
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    // 맴버의 (절대적) 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    // 생성자 구현 (memberId를 외부에서 건드리지 못하게 하려고 생성자로 구현했다.)
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        // 0일때는 0, 0이 아닐때는 타입저장속성의 절대적 값으로 셋팅 (자동순번)
        self.memberId = Member.memberNumbers
        
        // 나머지 저장속성은 외부에서 셋팅
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        // 맴버를 생성한다면, 항상 타입 저장속성의 정수값 + 1
        Member.memberNumbers += 1
    }
}
