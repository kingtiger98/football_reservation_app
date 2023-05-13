//
//  PlaceDetailViewController.swift
//  FootballResrvation
//
//  Created by 황재하 on 5/13/23.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    // 데이터를 받아올 프로퍼티
    var receivedPlaceNm: String?
    var receivedURL: String?
    
    var receivedPlaceLoca: String?
    var receivedReservationVali: String?
    var receivedMoneyState: String?
    var receivedReservationTime: String?
    var receiveduseDate: String?
    var receiveduseTime: String?
    var receivedPlaceTel: String?
    
    // 받아온 프로퍼티를 저장해 화면에 보여줄 아웃렛 변수
    @IBOutlet weak var PlaceNm: UILabel!
    
    @IBOutlet weak var PlaceLoca: UILabel!
    @IBOutlet weak var ReservationVali: UILabel!
    @IBOutlet weak var MoneyState: UILabel!
    @IBOutlet weak var ReservationTime: UILabel!
    @IBOutlet weak var useDate: UILabel!
    @IBOutlet weak var useTime: UILabel!
    @IBOutlet weak var PlaceTel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getValue()
    }

    func getValue(){
        guard let placeNm = receivedPlaceNm, let placeLoca = receivedPlaceLoca, let reservationvali = receivedReservationVali,
              let moneystate = receivedMoneyState, let placetel = receivedPlaceTel, let usedate = receiveduseDate
        
        else { return print("전 뷰에서 값 가져오기 실패") }
        PlaceNm.text = placeNm
        PlaceLoca.text = placeLoca
        ReservationVali.text = reservationvali
        MoneyState.text = moneystate
        PlaceTel.text = placetel
        useDate.text = usedate

        // 레이블 내 문자열 길면 글자 작아지게
        self.PlaceNm.adjustsFontSizeToFitWidth = true
        self.useDate.adjustsFontSizeToFitWidth = true
    }
    
    // 예약사이트 연결 버튼
    @IBAction func urlBtn(_ sender: UIButton) {
        guard let url = URL(string: self.receivedURL!) else { return print("Invalid URL") }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    
    }
