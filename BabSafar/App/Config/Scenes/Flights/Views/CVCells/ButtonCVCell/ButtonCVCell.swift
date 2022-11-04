//
//  ButtonCVCell.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit
protocol ButtonCVCellDelegate {
    func didTapOnAddCityBtn(cell:ButtonCVCell)
}

class ButtonCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnImg: UIImageView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var addCityBtn: UIButton!
    
    @IBOutlet weak var holderViewHeight: NSLayoutConstraint!
    
    var delegate:ButtonCVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        btnImg.image = UIImage(named: "btn")
        btnlbl.text = "+Add City"
        btnlbl.textColor = .AppTabSelectColor
        btnlbl.font = UIFont.LatoRegular(size: 16)
        addCityBtn.setTitle("", for: .normal)
    }
    
    
    @IBAction func didTapOnAddCityBtn(_ sender: Any) {
        delegate?.didTapOnAddCityBtn(cell: self)
    }
    
    
}
