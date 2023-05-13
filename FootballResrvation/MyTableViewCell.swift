//
//  MyTableViewCell.swift
//  FootballResrvation
//
//  Created by 황재하 on 5/12/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellBox: UIView!
    
    // 풋살장 이름
    @IBOutlet weak var placeName: UILabel!
    // 풋살장 위치
    @IBOutlet weak var locationName: UILabel!
    // 예약가능여부
    @IBOutlet weak var reservationState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellBox.frame = contentView.frame.inset(by: UIEdgeInsets(top:0 , left: 0, bottom: 10, right: 0))
        cellBox.layer.cornerRadius = 10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
