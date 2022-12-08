//
//  basefareTVCell.swift
//  BabSafar
//
//  Created by FCI on 02/12/22.
//

import UIKit

class basefareTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultslbl: UILabel!
    @IBOutlet weak var adultsKWDlbl: UILabel!
    @IBOutlet weak var lineView1: UIView!
    @IBOutlet weak var lineView2: UIView!
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var taxValuelbl: UILabel!
    @IBOutlet weak var totalPricelbl: UILabel!
    @IBOutlet weak var totalPriceValuelbl: UILabel!
    
    
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
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        holderView.backgroundColor = .WhiteColor
        lineView1.backgroundColor = HexColor("#E6E8E7")
        lineView2.backgroundColor = HexColor("#E6E8E7")
        titleView.backgroundColor = HexColor("#00A898")
        setuplabels(lbl: titlelbl, text: "Base Fare", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: adultslbl, text: "1 Adult(1x22)", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: taxlbl, text: "Taxes & Fees", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: totalPricelbl, text: "Total Price", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: adultsKWDlbl, text: "KWD 59.00", textcolor: HexColor("#808089"), font: .LatoSemibold(size: 14), align: .right)
        setuplabels(lbl: taxValuelbl, text: "35.00", textcolor: HexColor("#808089"), font: .LatoSemibold(size: 14), align: .right)
        setuplabels(lbl: totalPriceValuelbl, text: "94.0", textcolor: HexColor("#808089"), font: .LatoSemibold(size: 14), align: .right)
        
        
    }
    
}
