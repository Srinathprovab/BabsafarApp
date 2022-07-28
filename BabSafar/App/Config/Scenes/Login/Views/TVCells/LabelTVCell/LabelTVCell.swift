//
//  LabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

protocol LabelTVCellDelegate {
    func didTapOnCloseBtn(cell:LabelTVCell)
}

class LabelTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var menuOptionImage: UIImageView!
    @IBOutlet weak var menuOptionWidthConstaraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblLeftConstraint: NSLayoutConstraint!
    
    var delegate:LabelTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoRegular(size: 20)
        titlelbl.numberOfLines = 0
        closeButton.isHidden = true
        
        menuOptionWidthConstaraint.constant = 0
        menuOptionImage.image = UIImage(named: "facebook")
        menuOptionImage.contentMode = .scaleToFill
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        
        switch cellInfo?.key {
        case "showbtn":
            closeButton.isHidden = false
            break
            
        case "menu":
            closeButton.isHidden = true
            menuOptionWidthConstaraint.constant = 20
            lblLeftConstraint.constant = 60
            menuOptionImage.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppCalenderDateSelectColor)
            break
            
        case "ourproducts":
            closeButton.isHidden = true
            menuOptionImage.isHidden = true
            holderView.backgroundColor = .AppBorderColor
            titlelbl.font = UIFont.LatoLight(size: 20)
            menuOptionWidthConstaraint.constant = 0
            break
            
        case "booked":
            titlelbl.font = UIFont.LatoRegular(size: 16)
            titlelbl.textColor = HexColor("#5B5B5B")
            titlelbl.numberOfLines = 0
            titlelbl.textAlignment = .center
            lblLeftConstraint.constant = 30
            break
            
        case "privacy":
            titlelbl.font = UIFont.LatoLight(size: 16)
            titlelbl.textColor = .AppLabelColor
            titlelbl.numberOfLines = 0
            break
            
        case "cpwd":
            titlelbl.font = UIFont.LatoRegular(size: 16)
            titlelbl.textColor = .AppLabelColor
            titlelbl.numberOfLines = 0
            break
            
        case "email":
            titlelbl.textColor = HexColor("#5B5B5B")
            break
            
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        delegate?.didTapOnCloseBtn(cell: self)
    }
    
}
