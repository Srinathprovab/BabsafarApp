//
//  FareRulesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class FareRulesTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        titlelbl.text = "Cancellation fees"
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoSemibold(size: 16)
        
        subTitlelbl.text = fareRulehtml
        subTitlelbl.textColor = .AppLabelColor
        subTitlelbl.font = UIFont.LatoLight(size: 14)
        subTitlelbl.numberOfLines = 0
        
    }
    
}
