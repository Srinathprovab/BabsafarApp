//
//  SideMenuTitleTVCell.swift
//  BabSafar
//
//  Created by FCI on 20/02/23.
//

import UIKit

class SideMenuTitleTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var menuOptionImg: UIImageView!
    @IBOutlet weak var menuTitlelbl: UILabel!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        menuOptionImg.isHidden = false
        holderView.backgroundColor = .WhiteColor
        imgWidth.constant = 22
    }
    
    override func updateUI() {
        menuTitlelbl.text = cellInfo?.title ?? ""
        menuOptionImg.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        
        if cellInfo?.key == "products" {
            menuOptionImg.isHidden = true
            holderView.backgroundColor = HexColor("#E6E8E7")
            setuplabels(lbl: menuTitlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .LatoLight(size: 16), align: .left)
            imgWidth.constant = 0

        }
    }
    
    
    func setupUI(){
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: menuTitlelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 16), align: .left)
        imgWidth.constant = 22
    }
    
}
