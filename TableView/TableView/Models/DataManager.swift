//
//  DataManager.swift
//  TableView
//
//  Created by KSH on 2022/12/04.
//

import UIKit

class DataManager {
    // movieData들을 바로 안넣는 이유는 ?
    // movieDataArray를 생성 후 바로 data를 넣어도 상관없지만,
    // 일반적으로 앱을 만들면 우리가 만든 DataManager는 빈 배열로 시작을 하고, 서버와 통신을 해서 통신 결과를 가져와서 배열에 할당하는 형식으로 진행이 되는것을 연습하기 위해서 data들을 바로 넣지 않았다.
    private var movieDataArray: [Movie] = []
    
    func makeMovieData() {
        movieDataArray = [
            Movie(movieImage: UIImage(named: "blackpanther.jpeg"), movieName: "블랙팬서2", movieDescription: "국왕이자 ‘블랙 팬서’인 '티찰라'의 죽음 이후 수많은 강대국으로부터 위협을 받게 된 와칸다의 이야기"),
            Movie(movieImage: UIImage(named: "hyojoo.jpeg"), movieName: "뷰티인사이드", movieDescription: "남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자의 이야기"),
            Movie(movieImage: UIImage(named: "meto.jpeg"), movieName: "동감", movieDescription: "시간을 뛰어넘어 기적처럼 연결된 ‘용’과 ‘무늬’는 서로의 사랑과 우정을 이야기"),
            Movie(movieImage: UIImage(named: "nope.jpeg"), movieName: "놉", movieDescription: "그것은 우리 위에 있다.거대하고, 주목받길 원하고, 미쳤다. 나쁜 기적이라는 것도 있을까? "),
            Movie(movieImage: UIImage(named: "interstellar.jpeg"), movieName: "인터스텔라", movieDescription: " 우린 답을 찾을 거야, 늘 그랬듯이 세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다."),
            Movie(movieImage: UIImage(named: "blackpanther.jpeg"), movieName: "블랙팬서2", movieDescription: "국왕이자 ‘블랙 팬서’인 '티찰라'의 죽음 이후 수많은 강대국으로부터 위협을 받게 된 와칸다의 이야기"),
            Movie(movieImage: UIImage(named: "hyojoo.jpeg"), movieName: "뷰티인사이드", movieDescription: "남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자의 이야기"),
            Movie(movieImage: UIImage(named: "meto.jpeg"), movieName: "동감", movieDescription: "시간을 뛰어넘어 기적처럼 연결된 ‘용’과 ‘무늬’는 서로의 사랑과 우정을 이야기"),
            Movie(movieImage: UIImage(named: "nope.jpeg"), movieName: "놉", movieDescription: "그것은 우리 위에 있다.거대하고, 주목받길 원하고, 미쳤다. 나쁜 기적이라는 것도 있을까? "),
            Movie(movieImage: UIImage(named: "interstellar.jpeg"), movieName: "인터스텔라", movieDescription: " 우린 답을 찾을 거야, 늘 그랬듯이 세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다.")
        ]
    }
    // 데이터 전달 메서드
    func getMovieData() -> [Movie] { return movieDataArray }
    
    func updateMovieData() {
        let movie = Movie(movieImage: UIImage(named: "hyojoo.jpeg"), movieName: "뷰티인사이드", movieDescription: "남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자의 이야기")
        movieDataArray.append(movie)
    }
}
