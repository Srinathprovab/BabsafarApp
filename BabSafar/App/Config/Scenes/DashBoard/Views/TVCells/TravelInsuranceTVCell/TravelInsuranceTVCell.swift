//
//  TravelInsuranceTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

protocol TravelInsuranceTVCellDelegate {
    
    func didTapOnInsureSkipButton(cell:TravelInsuranceTVCell)
    func didTapOnPABtn(cell:TravelInsuranceTVCell)
    func didTapOnTCBtn(cell:TravelInsuranceTVCell)
    func didTapOnTDBtn(cell:TravelInsuranceTVCell)
    func didTapOnTC1Btn(cell:TravelInsuranceTVCell)
    func didTapOnTD1Btn(cell:TravelInsuranceTVCell)
    func didTapOnShowMoreBtn(cell:TravelInsuranceTVCell)
    func didTapOnYesInsureBtn(cell:TravelInsuranceTVCell)
    func didTapOnNoInsureBtn(cell:TravelInsuranceTVCell)
    
}

class TravelInsuranceTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var insureImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var personalAccidentView: UIView!
    @IBOutlet weak var paCheckBoxImg: UIImageView!
    @IBOutlet weak var paImg: UIImageView!
    @IBOutlet weak var palbl: UILabel!
    @IBOutlet weak var paKWDlbl: UILabel!
    @IBOutlet weak var paBtn: UIButton!
    @IBOutlet weak var tripCancellationView: UIView!
    @IBOutlet weak var tcCheckBoxImg: UIImageView!
    @IBOutlet weak var tcImg: UIImageView!
    @IBOutlet weak var tclbl: UILabel!
    @IBOutlet weak var tcKWDlbl: UILabel!
    @IBOutlet weak var tcBtn: UIButton!
    @IBOutlet weak var tripDelayView: UIView!
    @IBOutlet weak var tdCheckBoxImg: UIImageView!
    @IBOutlet weak var tdImg: UIImageView!
    @IBOutlet weak var tdlbl: UILabel!
    @IBOutlet weak var tdKWDlbl: UILabel!
    @IBOutlet weak var tdBtn: UIButton!
    @IBOutlet weak var tripCancellationView1: UIView!
    @IBOutlet weak var tcCheckBoxImg1: UIImageView!
    @IBOutlet weak var tcImg1: UIImageView!
    @IBOutlet weak var tclbl1: UILabel!
    @IBOutlet weak var tcKWDlbl1: UILabel!
    @IBOutlet weak var tcBtn1: UIButton!
    @IBOutlet weak var tripDelayView1: UIView!
    @IBOutlet weak var tdCheckBoxImg1: UIImageView!
    @IBOutlet weak var tdImg1: UIImageView!
    @IBOutlet weak var tdlbl1: UILabel!
    @IBOutlet weak var tdKWDlbl1: UILabel!
    @IBOutlet weak var tdBtn1: UIButton!
    @IBOutlet weak var optionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var showMoreView: UIView!
    @IBOutlet weak var showMorelbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var radio1View: UIView!
    @IBOutlet weak var radioImg1: UIImageView!
    @IBOutlet weak var yeslbl: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var radio2View: UIView!
    @IBOutlet weak var radioImg2: UIImageView!
    @IBOutlet weak var nolbl: UILabel!
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var optionView: UIStackView!
    
    var delegate:TravelInsuranceTVCellDelegate?
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
        optionViewHeight.constant = 0
        optionView.isHidden = true
    }
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: personalAccidentView, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        setupViews(v: tripCancellationView, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        setupViews(v: tripDelayView, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        setupViews(v: tripCancellationView1, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        setupViews(v: tripDelayView1, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        setupViews(v: showMoreView, radius: 4, color: HexColor("#FCEDFF"))
        setupViews(v: radio1View, radius: 0, color: .WhiteColor)
        radio1View.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: radio2View, radius: 0, color: .WhiteColor)
        radio2View.layer.borderColor = UIColor.WhiteColor.cgColor
        
        
        insureImg.image = UIImage(named:"tinsure")?.withRenderingMode(.alwaysOriginal)
        paCheckBoxImg.image = UIImage(named:"tcheck")?.withRenderingMode(.alwaysOriginal)
        paImg.image = UIImage(named:"taccedient")?.withRenderingMode(.alwaysOriginal)
        tcCheckBoxImg.image = UIImage(named:"tcheck")?.withRenderingMode(.alwaysOriginal)
        tcImg.image = UIImage(named:"tcancel")?.withRenderingMode(.alwaysOriginal)
        tdCheckBoxImg.image = UIImage(named:"tcheck")?.withRenderingMode(.alwaysOriginal)
        tdImg.image = UIImage(named:"tflight")?.withRenderingMode(.alwaysOriginal)
        tcCheckBoxImg1.image = UIImage(named:"tcheck")?.withRenderingMode(.alwaysOriginal)
        tcImg1.image = UIImage(named:"tcancel")?.withRenderingMode(.alwaysOriginal)
        tdCheckBoxImg1.image = UIImage(named:"tcheck")?.withRenderingMode(.alwaysOriginal)
        tdImg1.image = UIImage(named:"tflight")?.withRenderingMode(.alwaysOriginal)
        radioImg1.image = UIImage(named:"radioUnselected")?.withRenderingMode(.alwaysOriginal)
        radioImg2.image = UIImage(named:"radioUnselected")?.withRenderingMode(.alwaysOriginal)
        
        
        setupLabels(lbl: titlelbl, text: "Travel Insurance", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: subTitlelbl, text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis in est sed pharetra, adipiscing vel.", textcolor: .SubTitleColor, font: .LatoRegular(size: 12))
        subTitlelbl.numberOfLines = 0
        setupLabels(lbl: palbl, text: "Personal Accident", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: paKWDlbl, text: "kWD: 250.00", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 12))
        setupLabels(lbl: tclbl, text: "Trip Cancellation", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: tcKWDlbl, text: "kWD: 250.00", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 12))
        setupLabels(lbl: tdlbl, text: "Trip Delay", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: tdKWDlbl, text: "kWD: 250.00", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 12))
        setupLabels(lbl: tclbl1, text: "Trip Cancellation", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: tcKWDlbl1, text: "kWD: 250.00", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 12))
        setupLabels(lbl: tdlbl1, text: "Trip Delay", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: tdKWDlbl1, text: "kWD: 250.00", textcolor: HexColor("#64276F"), font: .LatoMedium(size: 12))
        setupLabels(lbl: showMorelbl, text: "+ show more ", textcolor: .AppTabSelectColor, font: .LatoMedium(size: 12))
        setupLabels(lbl: yeslbl, text: "Yes I  Want My Trip With Insurance", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: nolbl, text: "No, I Do Not Want To Insurance My Trip", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        
        
        skipBtn.setTitle("Skip", for: .normal)
        skipBtn.setTitleColor(.AppTabSelectColor, for: .normal)
        skipBtn.titleLabel?.font = UIFont.LatoSemiboldItalic(size: 12)
        paBtn.setTitle("", for: .normal)
        tcBtn.setTitle("", for: .normal)
        tdBtn.setTitle("", for: .normal)
        tcBtn1.setTitle("", for: .normal)
        tdBtn1.setTitle("", for: .normal)
        showMoreBtn.setTitle("", for: .normal)
        yesBtn.setTitle("", for: .normal)
        noBtn.setTitle("", for: .normal)
        
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
    
    
    
    @IBAction func didTapOnInsureSkipButton(_ sender: Any) {
        delegate?.didTapOnInsureSkipButton(cell: self)
    }
    
    
    @IBAction func didTapOnPABtn(_ sender: Any) {
        delegate?.didTapOnPABtn(cell: self)
    }
    
    
    @IBAction func didTapOnTCBtn(_ sender: Any) {
        delegate?.didTapOnTCBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTDBtn(_ sender: Any) {
        delegate?.didTapOnTDBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTC1Btn(_ sender: Any) {
        delegate?.didTapOnTC1Btn(cell: self)
    }
    
    
    @IBAction func didTapOnTD1Btn(_ sender: Any) {
        delegate?.didTapOnTD1Btn(cell: self)
    }
    
    
    @IBAction func didTapOnShowMoreBtn(_ sender: Any) {
        delegate?.didTapOnShowMoreBtn(cell: self)
    }
    
    
    @IBAction func didTapOnYesInsureBtn(_ sender: Any) {
        delegate?.didTapOnYesInsureBtn(cell: self)
    }
    
    
    @IBAction func didTapOnNoInsureBtn(_ sender: Any) {
        delegate?.didTapOnNoInsureBtn(cell: self)
    }
    
    
}
