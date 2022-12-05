//
//  ViewController.swift
//  TableView
//
//  Created by KSH on 2022/12/03.
//

import UIKit
// TableView를 사용하려면 UITableViewDataSource를 채택해야함
class ViewController: UIViewController {
    // 테이블뷰의 데이터를 표시하기 위한 배열
//    var moviesArray: [Movie] = []
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var movieDataManager = DataManager()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupDatas()
    }
    
    func setUpTableView() {
        // 요약: 델리게이트 패턴의 대리자 설정
        // UITableViewDataSource를 채택했기 때문에 delegate pattern과 같이 self(ViewController)를 할당해줌
        // 그래서 이게 무슨 소리? -> TableView에 대리자가 self(ViewController)가 된다는 뜻이다!
        tableView.dataSource = self
        tableView.delegate = self
        // cell 높이 설정
        tableView.rowHeight = 120
    }
    
    func setupDatas() {
//      movieDataManager에서 movieData받아와서 저장
        movieDataManager.makeMovieData() // 일반적으로는 서버에 요청
//      moviesArray = movieDataManager.getMovieData() // 데이터 받아서 뷰컨의 배열에 저장
    }
}

// 일반적으로 프로토콜을 채택 후 메서드를 구현할때 가독성을 위해 extension을 사용해서 따로 분리해준다.
extension ViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 VC에게 물어보는 메서드(numberOfRowsInSection) ❗️반드시 구현❗️
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataManager.getMovieData().count // 컨텐츠가 몇개인지 카운트
    }
    
    // 2) 셀의 구성 (셀에 표시하고자 하는 데이터 표시)을 VC에게 물어보는 메서드(cellForRowAt) ❗️반드시 구현❗️
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 기존의 만들어놨던 MovieCell을 꺼내서 사용하는 메서드(storyboard에서 사용하려는 cell에 Identifier을 설정해서 넣어주면됨!)
        // 원래 이 메서드는 UITableViewCell만 리턴하는데, 타입 캐스팅으로 내가 구체적으로 만든 실제적인 타입(MovieCell) 변경해서 사용
        
        // (힙에 올라간)재사용 가능한 셀을 꺼내서 사용하는 메서드
        // (사전에 셀을 등록하는 과정이 내부 매커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
//        indexPath.section -> 그룹의 번호를 매기는것
//        indexPath.row -> 그룹에서 행의 번호
        
        let array = movieDataManager.getMovieData() // movieDataManager에서 데이터 받은 후,
        let movie = array[indexPath.row]            // 세부적인 행 추출
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none // cell 클릭 시 반응조절 메서드
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을때 어떤 동작을 할 것인지 VC에 물어보는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // segue연결 메서드 (withIdentifier에 내가 원하는Segue의 Identifier 입력)
        // sender에 IndexPath정보를 prepare메서드 (array[indexPath])에 전달
        performSegue(withIdentifier: "toDetail", sender: indexPath) // 세그웨이를 실행
    }
    
    // prepare세그웨이(데이터 전달) -> Storyboard를 이용 시 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" { // 1) prepare에서는 identifier를 먼저 확인
            
            // destination은 UIVC타입이라 다운 캐스팅으로 구체적인DetailVC를 불러온다.
            let detailVC = segue.destination as! DetailViewController // 2) 다음 화면으로 접근
            
            let array = movieDataManager.getMovieData() // movieDataManager에서 데이터 받아서 담기
            let index = sender as! IndexPath
            
            // 배열에서 아이템을 꺼내서, 다음화면으로 전달
            detailVC.movieData = array[index.row]
            
        }
    }
}

