//
//  FareBreakdownTitleTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/01/23.
//

import UIKit

class FareBreakdownTitleTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lblHolderView: UIView!
    
    
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
      //  holderView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#E6E8E7"), cornerRadius: 4)
        setuplabels(lbl: titlelbl, text: "Fare Breakdown", textcolor: .WhiteColor, font: .LatoBold(size: 16), align: .center)
        
        lblHolderView.backgroundColor = .AppCalenderDateSelectColor
        lblHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
    }
    
}
