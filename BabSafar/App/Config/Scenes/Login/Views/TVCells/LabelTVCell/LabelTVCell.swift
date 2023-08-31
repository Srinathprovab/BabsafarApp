//
//  LabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

protocol LabelTVCellDelegate {
    func didTapOnCloseBtn(cell:LabelTVCell)
    func didTapOnShowMoreBtn(cell:LabelTVCell)
}

class LabelTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var menuOptionImage: UIImageView!
    @IBOutlet weak var menuOptionWidthConstaraint: NSLayoutConstraint!
    @IBOutlet weak var lblLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var logoimg: UIImageView!
    
    var delegate:LabelTVCellDelegate?
    var showMoreBool = true
    var titleKey = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        
        titlelbl.textColor = .SubTitleColor
        titlelbl.font = UIFont.LatoRegular(size: 16)
        titlelbl.numberOfLines = 0
        closeButton.isHidden = true
        
        menuOptionWidthConstaraint.constant = 0
        // menuOptionImage.image = UIImage(named: "facebook")
        menuOptionImage.contentMode = .scaleToFill
        
        showMoreBtn.isHidden = true
        showMoreBtn.setTitle("+ Show More", for: .normal)
        showMoreBtn.setTitleColor(.AppTabSelectColor, for: .normal)
        showMoreBtn.titleLabel?.font = UIFont.LatoMedium(size: 15)
        
        logoimg.isHidden = true
    }
    
    override func prepareForReuse() {
        holderView.backgroundColor = .WhiteColor
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        self.titleKey = cellInfo?.key1 ?? ""
        menuOptionImage.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppCalenderDateSelectColor)
        
        switch cellInfo?.key {
            
            
        case "bc":
            titlelbl.textColor = .AppTabSelectColor
            titlelbl.textAlignment = .center
            titlelbl.font = .LatoBold(size: 16)
            break
            
        case "showbtn":
            closeButton.isHidden = false
            break
            
            
        case "loginshowbtn":
            closeButton.isHidden = false
            logoimg.isHidden = false
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
            titlelbl.font = UIFont.LatoRegular(size: 13)
            titlelbl.textColor = HexColor("#5B5B5B")
            titlelbl.numberOfLines = 2
            titlelbl.textAlignment = .center
            lblLeftConstraint.constant = 30
            break
            
        case "fdetails":
            titlelbl.font = UIFont.LatoBold(size: 20)
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
            titlelbl.font = UIFont.LatoRegular(size: 14)
            titlelbl.textColor = .AppLabelColor
            titlelbl.numberOfLines = 0
            break
            
        case "email":
            titlelbl.textColor = HexColor("#5B5B5B")
            break
            
        case "modifyhotel":
            closeButton.isHidden = false
            titlelbl.textAlignment = .center
            break
            
            
            
        case "filter":
            if showMoreBool == true {
                showMoreBtn.isHidden = false
            }else {
                showMoreBtn.isHidden = true
                viewHeight.constant = 0
            }
            closeButton.isHidden = true
            menuOptionImage.isHidden = true
            titlelbl.isHidden = true
            break
            
            
        case "reset":
            closeButton.isHidden = false
            closeButton.setImage(UIImage(named: ""), for: .normal)
            closeButton.setTitle("Reset", for: .normal)
            closeButton.titleLabel?.textColor = .AppTabSelectColor
            closeButton.titleLabel?.font = UIFont.LatoRegular(size: 16)
            break
            
            
        case "dropdown":
            closeButton.isHidden = false
            closeButton.setImage(UIImage(named: "down"), for: .normal)
            closeButton.setTitle("", for: .normal)
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
    
    
    func addAdultsDetailsSetup() {
        closeButton.isHidden = true
        showMoreBtn.isHidden = true
        lblLeftConstraint.constant = 40
        menuOptionImage.isHidden = false
        menuOptionImage.image = UIImage(named: "check")
    }
    
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        delegate?.didTapOnCloseBtn(cell: self)
    }
    
    
    @IBAction func didTapOnShowMoreBtn(_ sender: Any) {
        delegate?.didTapOnShowMoreBtn(cell: self)
    }
    
    
    
}
