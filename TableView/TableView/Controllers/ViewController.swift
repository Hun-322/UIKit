//
//  ViewController.swift
//  TableView
//
//  Created by KSH on 2022/12/03.
//

import UIKit
// TableView를 사용하려면 UITableViewDataSource를 채택해야함
class ViewController: UIViewController,UITableViewDataSource{
    // 영화데이터를 가지고있는 저장속성
    var moviesArray: [Movie] = [
        Movie(movieImage: UIImage(named: "blackpanther.jpeg"), movieName: "블랙팬서2", movieDescription: "국왕이자 ‘블랙 팬서’인 '티찰라'의 죽음 이후 수많은 강대국으로부터 위협을 받게 된 와칸다의 이야기"),
        Movie(movieImage: UIImage(named: "hyojoo.jpeg"), movieName: "뷰티인사이드", movieDescription: "남자, 여자, 아이, 노인.. 심지어 외국인까지! 자고 일어나면 매일 다른 모습으로 변하는 남자의 이야기"),
        Movie(movieImage: UIImage(named: "meto.jpeg"), movieName: "동감", movieDescription: "시간을 뛰어넘어 기적처럼 연결된 ‘용’과 ‘무늬’는 서로의 사랑과 우정을 이야기"),
        Movie(movieImage: UIImage(named: "nope.jpeg"), movieName: "놉", movieDescription: "그것은 우리 위에 있다.거대하고, 주목받길 원하고, 미쳤다. 나쁜 기적이라는 것도 있을까? "),
        Movie(movieImage: UIImage(named: "interstellar.jpeg"), movieName: "인터스텔라", movieDescription: " 우린 답을 찾을 거야, 늘 그랬듯이 세계 각국의 정부와 경제가 완전히 붕괴된 미래가 다가온다.")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UITableViewDataSource를 채택했기 때문에 delegate pattern과 같이 self(ViewController)를 할당해줌
        // 그래서 이게 무슨 소리? -> TableView에 대리자가 self(ViewController)가 된다는 뜻이다!
        tableView.dataSource = self
        tableView.rowHeight = 120
        
    }
    
    // 몇개의 컨텐츠를 만들면되는지 알려주는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 컨텐츠가 몇개인지 카운트
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기존의 만들어놨던 MovieCell을 꺼내서 사용하는 메서드(storyboard에서 사용하려는 cell에 Identifier을 설정해서 넣어주면됨!
        // for: <#T##IndexPath#> 란? -> 몇번째 경로에 셀을 꺼낼껀지?
        // 원래 이 메서드는 UITableViewCell만 리턴하는데, 타입 캐스팅으로 내가 구체적으로 만든 실제적인 타입(MovieCell) 변경해서 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
//        indexPath.section -> 그룹의 번호를 매기는것
//        indexPath.row -> 그룹에서 행의 번호
        
        let movie = moviesArray[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        return cell
    }

}

