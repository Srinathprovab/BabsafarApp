//
//  BookedAdultDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedAdultDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var seatlbl: UILabel!
    
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
        setupLabels(lbl: travellerNamelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        setupLabels(lbl: typelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        setupLabels(lbl: seatlbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14))
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}
