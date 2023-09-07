//
//  QuickBookingResultTVCell.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit

protocol QuickBookingResultTVCellDelegate {
    func didTapOnSelectBtnAction(cell:QuickBookingResultTVCell)
}

class QuickBookingResultTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    
    
   
    var delegate:QuickBookingResultTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        setAttributedText(str1: cellInfo?.subTitle ?? "" , str2: cellInfo?.price ?? "", lbl: pricelbl)
    }
    
    @IBAction func didTapOnSelectBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectBtnAction(cell: self)
    }
}
