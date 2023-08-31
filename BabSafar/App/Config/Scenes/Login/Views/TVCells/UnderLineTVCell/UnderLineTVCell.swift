//
//  UnderLineTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol UnderLineTVCellPrtocal {
    func didTapOnLoginBtn(cell:UnderLineTVCell)
    func didTapOnSignUpBtn(cell:UnderLineTVCell)
}

class UnderLineTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var rightLineView: UIView!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btnTitlelbl: UILabel!
    
    
    var delegate:UnderLineTVCellPrtocal?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        btnTitlelbl.text = cellInfo?.title ?? ""
        titlelbl.text = cellInfo?.subTitle ?? ""
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        leftLineView.backgroundColor = HexColor("#A39797")
        rightLineView.backgroundColor = HexColor("#A39797")
        
        titlelbl.text = "Or"
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 14)
        
    }
    
    
    @IBAction func didTapOnBtnAction(_ sender: Any) {
        if btnTitlelbl.text == "Login" {
            delegate?.didTapOnLoginBtn(cell: self)
        }else {
            delegate?.didTapOnSignUpBtn(cell: self)
        }
    }
    
    
}
