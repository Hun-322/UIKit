//
//  ViewController.swift
//  TableView
//
//  Created by KSH on 2022/12/03.
//

import UIKit
// TableView를 사용하려면 UITableViewDataSource를 채택해야함
class ViewController: UIViewController {
    // 영화데이터를 가지고있는 저장속성
//    var moviesArray: [Movie] = []
    var movieDataManager = DataManager()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UITableViewDataSource를 채택했기 때문에 delegate pattern과 같이 self(ViewController)를 할당해줌
        // 그래서 이게 무슨 소리? -> TableView에 대리자가 self(ViewController)가 된다는 뜻이다!
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        // 먼저 makeMovieData를 생성 후,
        // movieDataManager에서 movieData받아와서 저장
        movieDataManager.makeMovieData()
//        moviesArray = movieDataManager.getMovieData()
    }
}

// 일반적으로 프로토콜을 채택 후 메서드를 구현할때 가독성을 위해 extension을 사용해서 따로 분리해준다.
extension ViewController: UITableViewDataSource {
    // numberOfRowsInSection -> 몇개의 컨텐츠를 만들면되는지 알려주는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 컨텐츠가 몇개인지 카운트
        return movieDataManager.getMovieData().count
    }
    // cellForRowAt -> 셀의 구성(셀을 어떻게 그릴까?)을 어떻게 할지 물어보는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 기존의 만들어놨던 MovieCell을 꺼내서 사용하는 메서드(storyboard에서 사용하려는 cell에 Identifier을 설정해서 넣어주면됨!
        // for: <#T##IndexPath#> 란? -> 몇번째 경로에 셀을 꺼낼껀지?
        // 원래 이 메서드는 UITableViewCell만 리턴하는데, 타입 캐스팅으로 내가 구체적으로 만든 실제적인 타입(MovieCell) 변경해서 사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
//        indexPath.section -> 그룹의 번호를 매기는것
//        indexPath.row -> 그룹에서 행의 번호
        
        let array = movieDataManager.getMovieData()
        let movie = array[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        // cell 클릭 시 반응조정 메서드
        cell.selectionStyle = .none
        
        return cell
    }
}

