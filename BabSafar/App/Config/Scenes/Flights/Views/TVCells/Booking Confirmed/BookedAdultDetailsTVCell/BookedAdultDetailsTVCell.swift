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
        setuplabels(lbl: travellerNamelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: typelbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: seatlbl, text: "", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 14), align: .center)
        
        
        travellerNamelbl.numberOfLines = 2
        typelbl.numberOfLines = 2
        seatlbl.numberOfLines = 2
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    
    func setAttributedText(str1:String,str2:String)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:HexColor("#5B5B5B"),NSAttributedString.Key.font:UIFont.LatoRegular(size: 14)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppCalenderDateSelectColor,NSAttributedString.Key.font:UIFont.LatoRegular(size: 10)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        travellerNamelbl.attributedText = combination
        
    }
    
   
    
}
