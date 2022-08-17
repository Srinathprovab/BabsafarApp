//
//  ContactTVCell.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class ContactTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var contactlbl: UILabel!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var phoneNumberlbl: UILabel!
    @IBOutlet weak var contactValuelbl: UILabel!
    @IBOutlet weak var emailValuelbl: UILabel!
    @IBOutlet weak var phoneNoValuelbl: UILabel!
    
    
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
        holderView.backgroundColor = HexColor("#64276F", alpha: 0.10)
        setupLabels(lbl: contactlbl, text: "Contact:", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 12))
        setupLabels(lbl: emaillbl, text: "Email:", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 12))
        setupLabels(lbl: phoneNumberlbl, text: "Phone Number:", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 12))
        
        setupLabels(lbl: contactValuelbl, text: "961-125-54879", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: emailValuelbl, text: "babsafar.gmail.com", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: phoneNoValuelbl, text: "+965 123 45789 ", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))


    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
}
