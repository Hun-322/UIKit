//
//  Movie.swift
//  TableView
//
//  Created by KSH on 2022/12/03.
//

import UIKit

struct Movie {
    // 이미지 파일이 없을수도 있기 떄문에 var로 선언 && Optional타입으로 선언
    var movieImage: UIImage?
    let movieName: String
    let movieDescription: String
}
