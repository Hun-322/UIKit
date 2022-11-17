//
//  BMICalculatorManager.swift
//  BMICalculator
//
//  Created by KSH on 2022/11/17.
//

import UIKit

// 프로젝트 단위가 작아서 struct로 구현
struct BMICalculatorManager {
    
    // BMI계산 결과값 보관을 위한 변수
    var bmi: Double?
    
    // BMI계산 메서드 mutating -> 내부에서 속성을 변경할려면 선언해줘야함
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0
            return
        }
        var bmiNumber = w / (h * h) * 10000
        bmi = round(bmiNumber * 10) / 10 // round -> 반올림함수
//        print("BMI결과값: \(bmi)")
    }
    // 결과값 반환 메서드
    func getBMIResult() -> Double {
        // 옵셔널을 사용안하는대신 ?? 0.0을 붙혀서 nil이 있으면 기본값으로 0.0이 들어가도록 선언
        return bmi ?? 0.0
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else {return UIColor.black}
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else {return ""}
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
}
