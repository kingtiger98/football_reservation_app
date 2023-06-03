//
//  ViewController.swift
//  FootballResrvation
//
//  Created by 황재하 on 5/12/23.
//

import UIKit

// MARK: - Welcome
struct PlaceData: Codable {
    let listPublicReservationSport: ListPublicReservationSport

        enum CodingKeys: String, CodingKey {
            case listPublicReservationSport = "ListPublicReservationSport"
        }
    }

    // MARK: - ListPublicReservationSport
    struct ListPublicReservationSport: Codable {
        let listTotalCount: Int
        let row: [Row]

        enum CodingKeys: String, CodingKey {
            case listTotalCount = "list_total_count"
            case row
        }
    }

    // MARK: - Row
    struct Row: Codable {
        let svcstatnm, svcnm, payatnm, placenm: String
        let svcurl: String
        let rcptbgndt, rcptenddt, areanm: String
        let  telno, vMin, vMax: String

        enum CodingKeys: String, CodingKey {
            case svcstatnm = "SVCSTATNM" // 예약 가능 상태
            case svcnm = "SVCNM" // 사용가능 요일, 주_야간 정보
            case payatnm = "PAYATNM" // 유료 or 무료
            case placenm = "PLACENM" // 풋살장 이름
            case svcurl = "SVCURL" // 예약 바로가기 URL

            // 풋살장 접수 시작 종료 년월일
            case rcptbgndt = "RCPTBGNDT"
            case rcptenddt = "RCPTENDDT"

            case areanm = "AREANM" // 위치 00구 이름
            case telno = "TELNO" // 풋살장 전화번호

            // 풋살장 이용시간
            case vMin = "V_MIN"
            case vMax = "V_MAX"
        }
    }


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // PlaceData형 프로퍼티 선언, 테이블에서 사용됨
    var placeData: PlaceData?
    
    // 테이블 아웃렛 연결
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self

        getData()
        naviSet()
    }
    
    // 테이블뷰 필수 메서드
    // row 갯수 지정 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 풋살장 수만큼 row 갯수 생성하도록
        guard let rnum = placeData?.listPublicReservationSport.listTotalCount else {
            return 0
        }
        return rnum
    }
    
    // 셀 생성 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell을 MyTableViewCell로 다운캐스팅하여 프로퍼티 접근
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyTableViewCell else {
            print("nil입니다.")
            return UITableViewCell()
        }
        
        cell.placeName.text = placeData?.listPublicReservationSport.row[indexPath.row].placenm
        cell.placeName.adjustsFontSizeToFitWidth = true // 글자가 너무 길면 자동으로 크기 줄이기
        
        cell.locationName.text = placeData?.listPublicReservationSport.row[indexPath.row].areanm
        cell.reservationState.text = placeData?.listPublicReservationSport.row[indexPath.row].svcstatnm
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 + 10
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue.identifier가 showDetail이면 if문 실행
        if segue.identifier == "showDetail" {
            // nextVC에 segue.destination을 넣고 segue.destination으로 다운캐스팅
            guard let nextVC = segue.destination as? PlaceDetailViewController else { return }
            // 선택한 셀의 row값을 selectRow에 저장
            guard let selectRow = self.table.indexPathForSelectedRow?.row else { return }
            // 두 번째 뷰의 프로퍼티에 값을 저장
            nextVC.receivedPlaceNm = placeData?.listPublicReservationSport.row[selectRow].placenm
            nextVC.receivedURL = placeData?.listPublicReservationSport.row[selectRow].svcurl
            nextVC.receivedPlaceLoca = placeData?.listPublicReservationSport.row[selectRow].areanm
            nextVC.receivedMoneyState = placeData?.listPublicReservationSport.row[selectRow].payatnm
            nextVC.receivedReservationVali = placeData?.listPublicReservationSport.row[selectRow].svcstatnm
            nextVC.receivedPlaceTel = placeData?.listPublicReservationSport.row[selectRow].telno
            nextVC.receiveduseDate = placeData?.listPublicReservationSport.row[selectRow].svcnm
            nextVC.receiveduseTimeMin = placeData?.listPublicReservationSport.row[selectRow].vMin
            nextVC.receiveduseTimeMax = placeData?.listPublicReservationSport.row[selectRow].vMax
            nextVC.receivedReservationTime1 = placeData?.listPublicReservationSport.row[selectRow].rcptbgndt
            nextVC.receivedReservationTime2 = placeData?.listPublicReservationSport.row[selectRow].rcptenddt
            
        }
    }
    
    // 스크롤 내릴 때 네비게이션 바 불투명해지는 현상 예방
    func naviSet(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    // 네트워킹 4단계
    func getData(){
        
        // "풋살장"을 그냥 url뒤에 쓰면 문자열이 인코딩되지 않아 오류가 발생해 아래와 같이 URL에 삽입할 수 있는 ASCII 문자로 변환해서 합해줘야함!
        let baseURL = "http://openapi.seoul.go.kr:8088/4872587345776f673639796f676879/json/ListPublicReservationSport/1/1000/" // 1~1000까지 조회
        let place = "풋살장"
        // URL 인코딩
        guard let encodedPlace = place.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return print("URL 인코딩 실패") }
        let placeURL = baseURL + encodedPlace
        
        // 네트워킹 1단계 : URL만들기
        guard let url = URL(string: placeURL) else { return print("네트워킹 1단계 실패") }
        // 네트워킹 2단계 : URLSession 만들기
        let session = URLSession(configuration: .default)
        // 네트워킹 3단계 : URLSession 인스턴스에게 task주기
        let task = session.dataTask(with: url) { data, response, error in // 네트워킹 4_1단계 : task시작하기
            if error != nil { print(error!); return }
            guard let JSONdata = data else { print(error!); return }
            
            // JSONDecoder() : JSON객체 타입의 인스턴스를 디코딩
            let decodcoder = JSONDecoder()
            // 오류가 잔뜩 뜸! do try catch 문을 이용해 error 핸들링을 해야함
            do { // do문 안에 디코딩 부분(try)을 넣으면 된다.
                let decodedData = try decodcoder.decode(PlaceData.self, from: JSONdata)
                self.placeData = decodedData // decodedData를 테이블뷰에서 사용하기위해

                DispatchQueue.main.async { // UI관련 소스는 메인 스레드에서 처리하기 위한 과정
                    self.table.reloadData()
                }
            } catch { // catch는 오류문
                print(error)
            }
        }
        // 네트워킹 4_2단계 : task시작하기
        task.resume()
    }
    
}



