//
//  UserSpecificationOptionsTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import UIKit

class UserSpecificationOptionsTVCell: UITableViewCell {
    
    
    
    @IBOutlet weak var chkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
