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
        baseFareValuelbl.text = cellInfo?.title ?? ""
        taxValuelbl.text = cellInfo?.subTitle ?? ""
        totalPaymentValuelbl.text = cellInfo?.buttonTitle ?? ""
    }
    
}
