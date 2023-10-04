//
//  PopularFiltersTVCell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol PopularFiltersTVCellDelegate {
    func didTapOnOneRatingViewBtn(cell:PopularFiltersTVCell)
    func didTapOnTwoRatingViewBtn(cell:PopularFiltersTVCell)
    func didTapOnThreeatingViewBtn(cell:PopularFiltersTVCell)
    func didTapOnFouratingViewBtn(cell:PopularFiltersTVCell)
    func didTapOnFivetingViewBtn(cell:PopularFiltersTVCell)
}

class PopularFiltersTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var onelbl: UILabel!
    @IBOutlet weak var oneImg: UIImageView!
    @IBOutlet weak var ontBtn: UIButton!
    @IBOutlet weak var twolbl: UILabel!
    @IBOutlet weak var twoImg: UIImageView!
    @IBOutlet weak var twoBtn: UIButton!
    @IBOutlet weak var threelbl: UILabel!
    @IBOutlet weak var threeImg: UIImageView!
    @IBOutlet weak var threeBtn: UIButton!
    @IBOutlet weak var fourlbl: UILabel!
    @IBOutlet weak var fourImg: UIImageView!
    @IBOutlet weak var fourBtn: UIButton!
    @IBOutlet weak var fivelbl: UILabel!
    @IBOutlet weak var fiveImg: UIImageView!
    @IBOutlet weak var fiveBtn: UIButton!
    @IBOutlet weak var oneRatingView: UIView!
    @IBOutlet weak var twoRatingView: UIView!
    @IBOutlet weak var threeRatingView: UIView!
    @IBOutlet weak var fourRatingView: UIView!
    @IBOutlet weak var fiveRatingView: UIView!
    
    
    
    var delegate:PopularFiltersTVCellDelegate?
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
        
        switch hotelfiltermodel.starRating {
        case "1":
            tapononeStar()
            break
            
            
        case "2":
            tapon2Star()
            break
            
            
        case "3":
            tapon3Star()
            break
            
            
        case "4":
            tapon4Star()
            break
            
            
        case "5":
            tapon5Star()
            break
            
            
        case "":
            reset()
            break
            
            
        default:
            
            break
        }
    }
    
    
    func setupUI() {
        
        
        setupViews(v: oneRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: twoRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: threeRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: fourRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: fiveRatingView, radius: 2, color: .WhiteColor)
        
        setupLabels(lbl: titlelbl, text: "Star Ratings", textcolor: .AppLabelColor, font: .LatoMedium(size: 17))
        setupLabels(lbl: onelbl, text: "1", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: twolbl, text: "2", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: threelbl, text: "3", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fourlbl, text: "4", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fivelbl, text: "5", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingunselect")
        
        ontBtn.setTitle("", for: .normal)
        twoBtn.setTitle("", for: .normal)
        threeBtn.setTitle("", for: .normal)
        fourBtn.setTitle("", for: .normal)
        fiveBtn.setTitle("", for: .normal)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func didTapOnOneRatingViewBtn(_ sender: Any) {
        
        tapononeStar()
    }
    
    
    func tapononeStar() {
        oneImg.image = UIImage(named: "ratingselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingunselect")
        oneRatingView.layer.borderColor = UIColor.AppTabSelectColor.cgColor
        twoRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        threeRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fourRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fiveRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        delegate?.didTapOnOneRatingViewBtn(cell: self)
    }
    
    @IBAction func didTapOnTwoRatingViewBtn(_ sender: Any) {
        tapon2Star()
    }
    
    
    func tapon2Star() {
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingunselect")
        oneRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        twoRatingView.layer.borderColor = UIColor.AppTabSelectColor.cgColor
        threeRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fourRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fiveRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        delegate?.didTapOnTwoRatingViewBtn(cell: self)
    }
    
    @IBAction func didTapOnThreeatingViewBtn(_ sender: Any) {
        tapon3Star()
    }
    
    func tapon3Star() {
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingunselect")
        oneRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        twoRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        threeRatingView.layer.borderColor = UIColor.AppTabSelectColor.cgColor
        fourRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fiveRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        delegate?.didTapOnThreeatingViewBtn(cell: self)
    }
    
    @IBAction func didTapOnFouratingViewBtn(_ sender: Any) {
        tapon4Star()
    }
    
    func tapon4Star() {
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingselect")
        fiveImg.image = UIImage(named: "ratingunselect")
        oneRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        twoRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        threeRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fourRatingView.layer.borderColor = UIColor.AppTabSelectColor.cgColor
        fiveRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        delegate?.didTapOnFouratingViewBtn(cell: self)
    }
    
    @IBAction func didTapOnFivetingViewBtn(_ sender: Any) {
        tapon5Star()
    }
    
    func tapon5Star() {
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingselect")
        oneRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        twoRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        threeRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fourRatingView.layer.borderColor = UIColor.AppBorderColor.cgColor
        fiveRatingView.layer.borderColor = UIColor.AppTabSelectColor.cgColor
        delegate?.didTapOnFivetingViewBtn(cell: self)
    }
    
    
    
    
    func reset(){
        
        setupViews(v: oneRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: twoRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: threeRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: fourRatingView, radius: 2, color: .WhiteColor)
        setupViews(v: fiveRatingView, radius: 2, color: .WhiteColor)
        
        setupLabels(lbl: titlelbl, text: "Star Ratings", textcolor: .AppLabelColor, font: .LatoMedium(size: 17))
        setupLabels(lbl: onelbl, text: "1", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: twolbl, text: "2", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: threelbl, text: "3", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fourlbl, text: "4", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: fivelbl, text: "5", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        oneImg.image = UIImage(named: "ratingunselect")
        twoImg.image = UIImage(named: "ratingunselect")
        threeImg.image = UIImage(named: "ratingunselect")
        fourImg.image = UIImage(named: "ratingunselect")
        fiveImg.image = UIImage(named: "ratingunselect")
    }
    
}
