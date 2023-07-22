//
//  TabSelectCVCell.swift
//  BabSafar
//
//  Created by FCI on 17/11/22.
//

import UIKit

class TabSelectCVCell: UICollectionViewCell {

    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    var imageStr = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.addCornerRadiusWithShadow(color: .clear , borderColor: .clear, cornerRadius: 6)
        holderView.backgroundColor = .white
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoBold(size: 14), align: .center)
    }
    
    
    
    func selected() {
        holderView.backgroundColor = .AppTabSelectColor
        img.image = UIImage(named: imageStr)?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
    
    func unselected() {
        holderView.backgroundColor = .WhiteColor
        img.image = UIImage(named: imageStr)?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
    }
    
 

}
