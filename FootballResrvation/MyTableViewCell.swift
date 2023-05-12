//
//  MyTableViewCell.swift
//  FootballResrvation
//
//  Created by 황재하 on 5/12/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    // 풋살장 이름
    @IBOutlet weak var placeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
