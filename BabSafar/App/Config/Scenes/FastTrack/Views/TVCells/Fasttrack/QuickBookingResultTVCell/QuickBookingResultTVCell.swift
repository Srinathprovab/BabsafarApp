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
    
    
   var exactprice = ""
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
        exactprice = cellInfo?.price ?? ""
        setAttributedTextnew(str1: cellInfo?.subTitle ?? "",
                             str2: cellInfo?.price ?? "",
                             lbl: pricelbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
    }
    
    @IBAction func didTapOnSelectBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectBtnAction(cell: self)
    }
}
