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
    
    
    var ratekey = String()
    var currency = ""
    var exactprice = ""
    var isSelectedCell: Bool = false {
        didSet {
            updateButtonColor()
        }
    }
    private var unselectedBackgroundColor: UIColor = .AppBtnColor

    
    var CancellationPolicyArray = [CancellationPolicies]()
    var selectedRoom = String()
    var indexpathvalue : IndexPath?
    var fareTypeString = String()
    var CancellationPolicyAmount = String()
    var CancellationPolicyFromDate = String()
   
    var ratekeyNewArray = [String]()
    var delegate:NewRoomDetailsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectRoomBtnView.backgroundColor = .AppBtnColor
        
//        selectRoomView.layer.borderColor = UIColor.green.cgColor
//       // selectRoomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
//        selectRoomView.layer.cornerRadius = 10
//        selectRoomView.clipsToBounds = true
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
