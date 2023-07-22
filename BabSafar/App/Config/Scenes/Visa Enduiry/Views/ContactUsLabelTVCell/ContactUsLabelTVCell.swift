//
//  ContactUsLabelTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/02/23.
//

import UIKit

protocol ContactUsLabelTVCellDelegate {
    func didTapOnOpenEmailButtonAction(cell:ContactUsLabelTVCell)
}

class ContactUsLabelTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lblLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailBtn: UIButton!
    
    
    var key1 = String()
    var delegate:ContactUsLabelTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
        img.image = UIImage(named: cellInfo?.image ?? "")
        key1 = cellInfo?.key1 ?? ""
        if cellInfo?.key == "bold" {
            setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 18), align: .left)
            img.isHidden = true
            lblLeftConstraint.constant = 16
        }
        
        
        switch cellInfo?.key1 {
        case "emailopen","customer":
            let text = cellInfo?.title ?? ""
            let underlineText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            titlelbl.attributedText = underlineText
            break

            
        default:
            break
        }
        
    }
    
    
    func setupUI(){
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        img.contentMode = .scaleToFill
        img.isHidden = false
        lblLeftConstraint.constant = 45
        emailBtn.addTarget(self, action: #selector(didTapOnOpenEmailButtonAction(_:)), for: .touchUpInside)

        
    }
    
    
    @objc func didTapOnOpenEmailButtonAction(_ sender:UIButton) {
        delegate?.didTapOnOpenEmailButtonAction(cell: self)
    }
    
    
    
}
