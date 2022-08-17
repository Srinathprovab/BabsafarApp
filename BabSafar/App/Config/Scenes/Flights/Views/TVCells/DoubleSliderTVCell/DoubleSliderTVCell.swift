//
//  DoubleSliderTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit
import SwiftRangeSlider

class DoubleSliderTVCell: TableViewCell {
    
    
    @IBOutlet weak var rangeSlider: RangeSlider!
    @IBOutlet weak var sliderHolderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var showSliderBtn: UIButton!
    
    @IBOutlet weak var downImg: UIImageView!
    var minimumValue = 10.0
    var maximumValue = 100.0
    var lowerValue = 10.0
    var upperValue = 100.0
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
        titlelbl.text = cellInfo?.text
    }
    
    
    func setupUI() {
//        sliderHolderViewHeight.constant = 0
//        rangeSlider.isHidden = true
        rangeSlider.backgroundColor = .WhiteColor
        rangeSlider.minimumValue = minimumValue
        rangeSlider.maximumValue = maximumValue
        rangeSlider.lowerValue = lowerValue
        rangeSlider.upperValue = upperValue
        rangeSlider.stepValue = 10
        rangeSlider.hideLabels = true
        
        // rangeSlider.trackThickness = 3
        rangeSlider.addTarget(self, action: #selector(self.rangeSliderValueChanged(slider:)), for: UIControl.Event.valueChanged)
        showSliderBtn.setTitle("", for: .normal)
        
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .LatoMedium(size: 17))
        
        downImg.image = UIImage(named: "down")
        
        contentView.bringSubviewToFront(titlelbl)

    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func rangeSliderValueChanged(slider: RangeSlider) {
        print("Min: \(slider.lowerValue), Max: \(slider.upperValue)")
    }
    
    
    
    @IBAction func showSliderBtn(_ sender: Any) {
        sliderHolderViewHeight.constant = 150
        rangeSlider.isHidden = false
        contentView.layoutIfNeeded()
    }
    
}
