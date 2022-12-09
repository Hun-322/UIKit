//
//  MemberListManager.swift
//  MemberList
//
//  Created by KSH on 2022/12/09.
//

import Foundation
// 비즈니스 로직과 관련된 Model
final class MemberListManager {
    
    private var memberList: [Member] = []
    
    func makeMembersListDatas() {
        memberList = [
            Member(name: "홍길동", age: 20, phone: "010-1111-2222", address: "서울"),
            Member(name: "임꺽정", age: 23, phone: "010-2222-3333", address: "부산"),
            Member(name: "스티브", age: 50, phone: "010-4444-5555", address: "미국"),
            Member(name: "쿡", age: 30, phone: "010-6666-7777", address: "캘리포니아"),
            Member(name: "베조스", age: 50, phone: "010-8888-9999", address: "하와이"),
            Member(name: "배트맨", age: 30, phone: "010-1234-5678", address: "고담씨티"),
            Member(name: "조커", age: 28, phone: "010-9876-5432", address: "고담씨티")
        ]
    }
    // 전체 멤버 리스트 얻기
    func getMembersList() -> [Member] {
        return memberList
    }
    
    // 새로운 멤버 만들기
    func makeNewMember(_ member: Member) {
        memberList.append(member)
    }
    
    // 기존 멤버의 정보 업데이트
    func updateMemberInfo(index: Int, _ member: Member) {
        memberList[index] = member
    }
    
    // 특정 멤버 얻기 (굳이 필요 없음, 서브스크립트 구현해보기)
    subscript(index: Int) -> Member {
        get {
            return memberList[index]
        }
    }
}
