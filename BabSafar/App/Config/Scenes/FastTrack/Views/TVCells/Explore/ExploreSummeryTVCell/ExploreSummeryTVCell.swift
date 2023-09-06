//
//  ExploreSummeryTVCell.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import UIKit

class ExploreSummeryTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var pricelbl1: UILabel!
    @IBOutlet weak var subTotallbl: UILabel!
    @IBOutlet weak var totalDiscountlbl: UILabel!
    @IBOutlet weak var totalAmountlbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        titlelbl.text = eproduct_details?.data?.from?.sku ?? ""
        
        setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? ""):", str2: eproduct_details?.data?.from?.price ?? "", lbl: pricelbl1)
        pricelbl1.isHidden = true
        
        setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? ""):", str2: eproduct_details?.data?.from?.price ?? "", lbl: subTotallbl)
        
        setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? ""):", str2: eproduct_details?.data?.from?.price ?? "", lbl: totalDiscountlbl)
        
        setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? ""):", str2: eproduct_details?.data?.from?.price ?? "", lbl: totalAmountlbl)
    }
    
    
    
   
        

    
}
