//
//  SortbyTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

protocol SortbyTVCellDelegate {
    func didTapOnLowtoHighBtn(cell:SortbyTVCell)
    func didTapOnHightoLowBtn(cell:SortbyTVCell)
    //    func didTapOnResetSortbyBtn(cell:SortbyTVCell)
}

class SortbyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var lowtoHighView: UIView!
    @IBOutlet weak var lowtoHighlbl: UILabel!
    @IBOutlet weak var lowtoHighBtn: UIButton!
    @IBOutlet weak var hightoLowView: UIView!
    @IBOutlet weak var hightoLowhlbl: UILabel!
    @IBOutlet weak var hightoLowBtn: UIButton!
    
    var selectedSortByOption = String()
    var delegate:SortbyTVCellDelegate?
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
        
        if cellInfo?.key == "airline" {
            setuplabels(lbl: lowtoHighlbl, text: "A-Z", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
            setuplabels(lbl: hightoLowhlbl, text: "Z-A", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        }
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupViews(v: buttonsView, radius: 4, color: .WhiteColor)
        setupViews(v: lowtoHighView, radius: 4, color: .WhiteColor)
        setupViews(v: hightoLowView, radius: 4, color: .WhiteColor)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoMedium(size: 17), align: .left)
        setuplabels(lbl: lowtoHighlbl, text: "Low to High", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: hightoLowhlbl, text: "High to Low", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        lowtoHighBtn.setTitle("", for: .normal)
        hightoLowBtn.setTitle("", for: .normal)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    @IBAction func didTapOnLowtoHighBtn(_ sender: Any) {
        delegate?.didTapOnLowtoHighBtn(cell: self)
    }
    
    @IBAction func didTapOnHightoLowBtn(_ sender: Any) {
        delegate?.didTapOnHightoLowBtn(cell: self)
    }
    
    
    
}
