//
//  FareRulesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

protocol FareRulesTVCellDelegate {
    func showContentBtnAction(cell:FareRulesTVCell)
}

class FareRulesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var dropDownImg: UIImageView!
   
    @IBAction func showContentBtnAction(_ sender: Any) {
        delegate?.showContentBtnAction(cell: self)
    }
    
    
    var delegate:FareRulesTVCellDelegate?
    
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
        hide()
    }
   
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title ?? ""
        subTitlelbl.text = cellInfo?.subTitle ?? ""
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        subTitlelbl.isHidden = true
        setuplabels(lbl: titlelbl, text: "Cancellation fees", textcolor: .AppLabelColor, font: .LatoMedium(size: 14), align: .left)
        setuplabels(lbl: subTitlelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        
        dropDownImg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#64276F"))
        
        downBtn.isHidden = true
    }
    
    
    func show() {
        subTitlelbl.isHidden = false
        dropDownImg.image = UIImage(named: "dropup")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func hide() {
        subTitlelbl.isHidden = true
        dropDownImg.image = UIImage(named: "down")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#64276F"))
    }
    
}
