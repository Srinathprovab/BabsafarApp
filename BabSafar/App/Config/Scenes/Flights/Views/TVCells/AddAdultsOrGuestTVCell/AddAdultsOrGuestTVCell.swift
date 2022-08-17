//
//  AddAdultsOrGuestTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit
protocol AddAdultsOrGuestTVCellDelegate {
    func didTapOnEditAdultBtn(cell:AddAdultsOrGuestTVCell)
}

class AddAdultsOrGuestTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    
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
        checkImg.image = UIImage(named: "check")
        editImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        editBtn.setTitle("", for: .normal)
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
    }
    
    
    
    @IBAction func didTapOnEditAdultBtn(_ sender: Any) {
        delegate?.didTapOnEditAdultBtn(cell: self)
    }
    
    
}
