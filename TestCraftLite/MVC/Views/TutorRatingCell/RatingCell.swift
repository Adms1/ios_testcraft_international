//
//  RatingCell.swift
//  TestCraftLite
//
//  Created by ADMS on 31/05/21.
//

import UIKit
import Cosmos

class RatingCell: UITableViewCell {

    @IBOutlet var lblUserName:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblMsg:UILabel!
    @IBOutlet var userImg:UIImageView!
    @IBOutlet var vwStarTutor:CosmosView!
    @IBOutlet var vwLine:UIView!
    @IBOutlet var lblUname:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
