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
    @IBOutlet weak var arrivalView: UIStackView!
    @IBOutlet weak var arrivalTitallbl: UILabel!
    @IBOutlet weak var arrivalPricelbl: UILabel!
    
    @IBOutlet weak var depView: UIStackView!
    @IBOutlet weak var arrivalViewHeight: NSLayoutConstraint!
    
    
    var totalAmount = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        if cellInfo?.key == "quick"{
            arrivalView.isHidden = false
            
            titlelbl.text = qproduct_details?.data?.from?.sku ?? ""
            arrivalTitallbl.text = qproduct_details?.data?.to?.sku ?? ""
            
            
            if quickServiceA.count == 1 {
                totalAmount = 0
                arrivalViewHeight.constant = 38
                quickServiceA.forEach({ i in
                    if i.serviceType == "dep" {
                        totalAmount = (qproduct_details?.data?.from?.price ?? 0) + totalAmount
                        arrivalView.isHidden = true
                    }else {
                        totalAmount = (qproduct_details?.data?.to?.price ?? 0) + totalAmount
                        depView.isHidden = true
                    }
                })
            }
            
            if quickServiceA.count == 2 {
                totalAmount = 0
                arrivalViewHeight.constant = 77
                quickServiceA.forEach({ i in
                    if i.serviceType == "dep" {
                        totalAmount = (qproduct_details?.data?.from?.price ?? 0) + totalAmount
                    }else {
                        totalAmount = (qproduct_details?.data?.to?.price ?? 0) + totalAmount
                    }
                })
            }
            
            
            setAttributedText(str1: "\(qproduct_details?.data?.from?.currency ?? "")", str2: "\(qproduct_details?.data?.from?.price ?? 0)", lbl: pricelbl1)
            
            setAttributedText(str1: "\(qproduct_details?.data?.to?.currency ?? "")", str2: "\(qproduct_details?.data?.to?.price ?? 0)", lbl: arrivalPricelbl)
            
           
            
            setAttributedText(str1: "\(qproduct_details?.data?.from?.currency ?? "")", str2: "\(totalAmount )", lbl: subTotallbl)
            
            setAttributedText(str1: "\(qproduct_details?.data?.from?.currency ?? "")", str2: "\(qproduct_details?.data?.from?.discount ?? 0)", lbl: totalDiscountlbl)
            
          
            
            setAttributedText(str1: "\(qproduct_details?.data?.from?.currency ?? "")", str2: "\(totalAmount )", lbl: totalAmountlbl)
            
        }else {
            arrivalView.isHidden = true
            arrivalViewHeight.constant = 38
            titlelbl.text = eproduct_details?.data?.from?.sku ?? ""
            setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? "")", str2: "\(qproduct_details?.data?.from?.price ?? 0)", lbl: pricelbl1)
            
            
            setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? "")", str2: "\(eproduct_details?.data?.from?.price ?? 0)", lbl: subTotallbl)
            
            setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? "")", str2: "\(eproduct_details?.data?.from?.price ?? 0)", lbl: totalDiscountlbl)
            
            setAttributedText(str1: "\(eproduct_details?.data?.from?.currency ?? "")", str2: "\(eproduct_details?.data?.from?.price ?? 0)", lbl: totalAmountlbl)
        }
    }
    
    
    
    
    func setupUI(){
        arrivalView.isHidden = true
    }
    
    
}
