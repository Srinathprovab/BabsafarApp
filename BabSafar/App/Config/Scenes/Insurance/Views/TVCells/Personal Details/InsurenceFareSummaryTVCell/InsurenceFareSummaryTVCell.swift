//
//  InsurenceFareSummaryTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class InsurenceFareSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var baseFareValuelbl: UILabel!
    @IBOutlet weak var taxValuelbl: UILabel!
    @IBOutlet weak var totalPaymentValuelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
       
        
        setAttributedTextnew(str1: "\(cellInfo?.tempText ?? "")",
                             str2: "\(cellInfo?.title ?? "")",
                             lbl: baseFareValuelbl,
                             str1font: .LatoBold(size: 10),
                             str2font: .LatoBold(size: 14),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
        
        setAttributedTextnew(str1: "\(cellInfo?.tempText ?? "")",
                             str2: "\(cellInfo?.subTitle ?? "")",
                             lbl: taxValuelbl,
                             str1font: .LatoBold(size: 10),
                             str2font: .LatoBold(size: 14),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
        
        
        setAttributedTextnew(str1: "\(cellInfo?.tempText ?? "")",
                             str2: "\(cellInfo?.buttonTitle ?? "")",
                             lbl: totalPaymentValuelbl,
                             str1font: .LatoBold(size: 10),
                             str2font: .LatoBold(size: 14),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
        
        
        
    }
    
}
