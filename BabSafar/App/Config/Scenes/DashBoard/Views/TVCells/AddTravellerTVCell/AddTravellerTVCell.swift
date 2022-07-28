//
//  AddTravellerTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
protocol AddTravellerTVCellDelegate {
    func didTapOnAddAdultBtn(cell:AddTravellerTVCell)
    func didTapOnAddChildBtn(cell:AddTravellerTVCell)
}
class AddTravellerTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addchildlbl: UILabel!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    
//    @IBOutlet weak var adultTVView: UIView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    var delegate:AddTravellerTVCellDelegate?
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
        //adultTVHeight.constant = 100
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addAdultHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        addChildHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addChildHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setupViews(v: addChildBtnView, radius: 15, color: HexColor("#FCEDFF"))
       // setupViews(v: adultTVView, radius: 0, color: .green)

        travelImg.image = UIImage(named: "travel")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "Traveller Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: addlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: addchildlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: totalNoOfTravellerlbl, text: "Total No Of  Tra : 2", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 12))

        addAdultBtn.setTitle("", for: .normal)
        addChildBtn.setTitle("", for: .normal)

       
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
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
}
