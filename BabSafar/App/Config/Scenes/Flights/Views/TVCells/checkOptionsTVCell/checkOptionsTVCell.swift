//
//  checkOptionsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class checkOptionsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var filtertitle = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if isSelected == true {
            sele()
        }else {
            unselected()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // reset cell UI here
        unselected()
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        if cellInfo?.key == "book" {
            contentView.backgroundColor = .WhiteColor
            holderView.backgroundColor = .AppHolderViewColor
            setAttributedString()
        }
    }
    
    
    func setAttributedString() {
        
        let str1 = "i Accept "
        let str2 = "T&C"
        let str3 = " and "
        let str4 = "Privacy Policy"
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:HexColor("#00A898"),NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        let atterStr3 = NSMutableAttributedString(string: str3, attributes: atter1)
        let atterStr4 = NSMutableAttributedString(string: str4, attributes: atter2)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        combination.append(atterStr3)
        combination.append(atterStr4)
        titlelbl.attributedText = combination
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        titlelbl.textColor = HexColor("#767676")
        titlelbl.font = UIFont.LatoRegular(size: 16)
        titlelbl.numberOfLines = 0
    }
    
    
    
    func sele() {
        checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func unselected() {
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
    }
    
}
