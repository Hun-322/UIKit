//
//  BMICalculatorManager.swift
//  BMICalculator
//
//  Created by KSH on 2022/11/17.
//

import UIKit

// 프로젝트 단위가 작아서 struct로 구현
// 비지니스 로직 담당 모델 - BMI계산과 관련된 모든 것
struct BMICalculatorManager {
    
    // BMI 저장변수
    private var bmi: BMI?
    
    // BMI얻기 메서드
    mutating func getBMI(height: String, weight: String) -> BMI {
        // BMI만들기 메서드 호출
        calculateBMI(height: height, weight: weight)
        // BMI리턴
        return bmi ?? BMI(value: 0.0, advice: "문제발생", MatchColor: .white)
    }
    
    // BMI만들기 메서드(BMI수치 계산해서, BMI구조체 인스턴스 만드는 메서드)
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "문제발생", MatchColor: .white)
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "저체중", MatchColor: color)
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", MatchColor: color)
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "과체중", MatchColor: color)
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "중도비만", MatchColor: color)
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            bmi = BMI(value: bmiNum, advice: "고도비만", MatchColor: color)
        default:
            bmi = BMI(value: 0.0, advice: "문제발생", MatchColor: .white)
        }
    }
}
