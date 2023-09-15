//
//  NewRoomDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 26/08/23.
//

import UIKit
protocol NewRoomDetailsTVCellDelegate {
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
    
}

class NewRoomDetailsTVCell: UITableViewCell {
    
    
    @IBOutlet weak var noofGuestlbl: UILabel!
    @IBOutlet weak var fareTypelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var bablbl: UILabel!
    @IBOutlet weak var selectRoomBtnView: BorderedView!
    
    
    var currency = ""
    var exactprice = ""
    var isSelectedCell: Bool = false {
        didSet {
            updateButtonColor()
        }
    }
    private var unselectedBackgroundColor: UIColor = .AppBtnColor

    var indexpathvalue : IndexPath?
    var fareTypeString = String()
    var CancellationPolicyAmount = String()
    var CancellationPolicyFromDate = String()
    var ratekey = String()
    var ratekeyNewArray = [String]()
    var delegate:NewRoomDetailsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectRoomBtnView.backgroundColor = .AppBtnColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func updateButtonColor() {
        selectRoomBtnView.backgroundColor = isSelectedCell ? .AppCalenderDateSelectColor : unselectedBackgroundColor
    }
    
    
    
    
    
    @IBAction func didTapOnCancellationPolicyBtnAction(_ sender: Any) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSelectRoomBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectRoomBtnAction(cell: self)
    }
    
    
}
