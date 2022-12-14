//
//  AddAdultsOrGuestTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit
protocol AddAdultsOrGuestTVCellDelegate {
    func didTapOnEditAdultBtn(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
}

class AddAdultsOrGuestTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    
    
    @IBOutlet weak var deleteBtnView: UIView!
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    
    var travellerId = String()
    var delegate:AddAdultsOrGuestTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        editBtnView.backgroundColor = .WhiteColor
        deleteBtnView.backgroundColor = .WhiteColor
        
        checkImg.image = UIImage(named: "check")
        editImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        deleteImg.image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        
        editBtn.setTitle("", for: .normal)
        deleteBtn.setTitle("", for: .normal)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        
        
    }
    
    
    
    @IBAction func didTapOnEditAdultBtn(_ sender: Any) {
        delegate?.didTapOnEditAdultBtn(cell: self)
    }
    
    
    
    
    @IBAction func didTapOndeleteTravellerBtnAction(_ sender: Any) {
        delegate?.didTapOndeleteTravellerBtnAction(cell: self)
    }
    
    
}
