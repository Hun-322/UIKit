//
//  RPS.swift
//  RPSGame
//
//  Created by KSH on 2022/07/07.
//

import UIKit

// 원시값(raw value)
enum RPS: Int{
    case ready
    case rock
    case paper
    case scissors
    
    // 계산 속성
    var rpsInfo: (image: UIImage, name: String) {
        switch self {
        case .ready:
            return (UIImage(imageLiteralResourceName: "ready"), "준비")
        case .rock:
            return (UIImage(imageLiteralResourceName: "rock"), "바위")
        case .paper:
            return (UIImage(imageLiteralResourceName: "paper"), "보")
        case .scissors:
            return (UIImage(imageLiteralResourceName: "scissors"), "가위")
        }
    }
}
