//
//  MyDropDownCell.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import UIKit
import DropDown

class MyDropDownCell: DropDownCell {
    
    @IBOutlet weak var myText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuplabels(lbl: myText, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
