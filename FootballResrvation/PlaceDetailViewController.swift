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
    
    var receiveduseTimeMin: String?
    var receiveduseTimeMax: String?

    var receivedPlaceTel: String?
    
    var receivedReservationTime1: String?
    var receivedReservationTime2: String?

    
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

    func getValue() {
        guard let placeNm = receivedPlaceNm,
              let placeLoca = receivedPlaceLoca,
              let reservationvali = receivedReservationVali,
              let moneystate = receivedMoneyState,
              let placetel = receivedPlaceTel,
              let usedate = receiveduseDate,
              let usetimeMin = receiveduseTimeMin,
              let usetimeMax = receiveduseTimeMax,
              let reservationtime1 = receivedReservationTime1,
              let reservationtime2 = receivedReservationTime2
        else {
            print("전 뷰에서 값 가져오기 실패")
            return
        }

        PlaceNm.text = placeNm
        PlaceLoca.text = "장소 : " + placeLoca
        ReservationVali.text = "예약 가능 여부 : " + reservationvali
        MoneyState.text = "요금유무 : " + moneystate

        if let dotRange1 = reservationtime1.range(of: ".") {
            let formattedTime1 = String(reservationtime1[..<dotRange1.lowerBound])
            ReservationTime.text = "예약 접수 시간\n" + "접수 시작 : " + formattedTime1 + "\n접수 종료 : "
        }

        if let dotRange2 = reservationtime2.range(of: ".") {
            let formattedTime2 = String(reservationtime2[..<dotRange2.lowerBound])
            ReservationTime.text?.append(formattedTime2)
        }

        useDate.text = "사용 가능 요일\n" + usedate
        useTime.text = "사용 가능 시간 : " + usetimeMin + " ~ " + usetimeMax
        PlaceTel.text = "전화번호 : " + placetel

        // 레이블 내 문자열이 길면 글자를 작게 조절
        PlaceNm.adjustsFontSizeToFitWidth = true
        useDate.adjustsFontSizeToFitWidth = true
    }

    
    
    // 전화 걸기 버튼
    
    @IBAction func callBtn(_ sender: UIButton) {
        guard let phoneNumber = receivedPlaceTel, let url = URL(string: "tel://\(phoneNumber)") else {
                return print("Invalid phone number")
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    // 예약사이트 연결 버튼
    @IBAction func urlBtn(_ sender: UIButton) {
        guard let url = URL(string: self.receivedURL!) else { return print("Invalid URL") }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
    
    }
