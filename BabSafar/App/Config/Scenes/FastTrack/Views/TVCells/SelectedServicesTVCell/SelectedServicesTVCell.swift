//
//  SelectedServicesTVCell.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit


protocol SelectedServicesTVCellDelegate {
    func didTapOnChangeSelectionBtnAction(cell:SelectedServicesTVCell)
    func didTapOnAddArrivalServiceBtnAction(cell:SelectedServicesTVCell)
    func didTapOnCheckOutBtnAction(cell:SelectedServicesTVCell)
}

class SelectedServicesTVCell: TableViewCell {
    
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var fromAirportNamelbl: UILabel!
    @IBOutlet weak var terminallbl: UILabel!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    var delegate:SelectedServicesTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        logoImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        fromAirportNamelbl.text = cellInfo?.title ?? ""
        terminallbl.text = cellInfo?.subTitle ?? ""
        
        if cellInfo?.key == "hide" {
            bottomHeight.constant = 0
        }
    }
    
    
    @IBAction func didTapOnChangeSelectionBtnAction(_ sender: Any) {
        delegate?.didTapOnChangeSelectionBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnAddArrivalServiceBtnAction(_ sender: Any) {
        delegate?.didTapOnAddArrivalServiceBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnCheckOutBtnAction(_ sender: Any) {
        delegate?.didTapOnCheckOutBtnAction(cell: self)
    }
    
    
    
    
}
