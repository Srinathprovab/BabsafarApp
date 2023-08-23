//
//  PlanContentTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class PlanContentTVCell: UITableViewCell {
    
    
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}
