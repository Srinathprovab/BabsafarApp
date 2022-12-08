//
//  NoteTVCell.swift
//  BabSafar
//
//  Created by FCI on 02/12/22.
//

import UIKit

class NoteTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func setupUI(){
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "Please Note: The add-on service charges, convenience fee, and the discount you have received using a coupon code is non-refundable. The final refund amount will be adjusted as per the deductions.*Airlines stop accepting cancellation/change requests 4 - 72 hours before departure of the flight, depending on the airline. The airline fee is indicative based on an automated interpretation of airline fare rules. Rehlat doesn't guarantee the accuracy of this information. The change/cancellation fee may also vary based on fluctuations in currency conversion rates. For exact cancellation/change fee, please call us at our customer care number.", textcolor: HexColor("#808089"), font: .LatoRegular(size: 12), align: .left)
    }
    
}
