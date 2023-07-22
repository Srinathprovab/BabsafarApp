//
//  FromCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class FromCityTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var plainImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var lblHolderView: UIView!
    @IBOutlet weak var cityShortNamelbl: UILabel!
    
    
    var id = String()
    var airportCode = String()
    var value = String()
    var citycode = String()
    var cityname = String()
    
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
        
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        plainImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#A3A3A3"))
        lblHolderView.layer.cornerRadius = 4
        lblHolderView.backgroundColor = HexColor("#E6E8E7")
        
        setupLabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: subTitlelbl, text: cellInfo?.subTitle ?? "", textcolor: .AppLabelColor, font: .LatoLight(size: 10))
        setupLabels(lbl: cityShortNamelbl, text: cellInfo?.text ?? "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        titlelbl.numberOfLines = 0
        subTitlelbl.numberOfLines = 0
        lblHolderView.isHidden = true
        
        
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
}
