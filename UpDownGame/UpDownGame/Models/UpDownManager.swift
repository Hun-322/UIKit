//
//  UpDownManager.swift
//  UpDownGame
//
//  Created by KSH on 2022/11/21.
//

import UIKit

struct UpDownManager {
    // 컴퓨터가 랜덤으로 숫자 선택(1...10)
    var comNumber = Int.random(in: 1...10)
    
    // 내가 선택한 숫자를 담는 변수
    private var myNumber: Int = 1
    
    mutating func resetNum() {
        // 컴퓨터의 랜덤숫자를 다시 선택하게
        comNumber = Int.random(in: 1...10)
        myNumber = 1
    }
    mutating func setUsersNum(num: Int) {
        myNumber = num
    }
    
    func getUpDownResult() -> String {
        // 컴퓨터의 숫자와 내가 선택한 숫자를 비교 UP / Down / Bingo (메인 레이블)
        if comNumber > myNumber {
            return "UP"
        } else if comNumber < myNumber {
            return "Down"
        } else {
            return "Bingo😎"
        }
    }
}
