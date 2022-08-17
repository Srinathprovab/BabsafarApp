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
        
        subTitlelbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mauris consectetur etiam ullamcorper netus ultrices integer. Malesuada ac id id aliquet. Duis sed nunc est feugiat neque malesuada a. Sed posuere quisque urna, nam interdum lacus, neque platea elit. Ultrices mauris bibendum faucibus eget eget accumsan fermentum. \n \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mauris consectetur etiam ullamcorper netus ultrices integer. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris mauris consectetur etiam ullamcorper netus ultrices integer. "
        subTitlelbl.textColor = .AppLabelColor
        subTitlelbl.font = UIFont.LatoLight(size: 14)
        subTitlelbl.numberOfLines = 0
        
    }
    
}
