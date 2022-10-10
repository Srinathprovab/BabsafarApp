//
//  SearchFlightsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

protocol SearchFlightsTVCellDelegate {
    func didTapOnFromCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnToCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnSwipeCityBtnAction(cell: SearchFlightsTVCell)
    func didTapOnDepartureBtnAction(cell: SearchFlightsTVCell)
    func didTapOnReturnBtnAction(cell: SearchFlightsTVCell)
    func addEconomyBtnAction(cell: SearchFlightsTVCell)
    func moreOptionBtnAction(cell: SearchFlightsTVCell)
    func didTapOnairlineBtnAction(cell: SearchFlightsTVCell)
    func didTapOntimeReturnJourneyBtnAction(cell: SearchFlightsTVCell)
    func didTapOntimeOutwardJourneyBtnAction(cell: SearchFlightsTVCell)
    func didTapOnReturnJurneyRadioButton(cell: SearchFlightsTVCell)
    func didTapOnDirectFlightRadioButton(cell: SearchFlightsTVCell)
    func didTapOnSearchFlightBtnAction(cell: SearchFlightsTVCell)
    
}
class SearchFlightsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeImage: UIImageView!
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var departurelbl: UILabel!
    @IBOutlet weak var departureDatelbl: UILabel!
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var returnlbl: UILabel!
    @IBOutlet weak var returnDatelbl: UILabel!
    @IBOutlet weak var economyView: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var economyValuelbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var moreExpandView: UIView!
    @IBOutlet weak var moreExpandViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var moreOptionsBtn: UIButton!
    @IBOutlet weak var moreBtnHolderView: UIView!
    
    @IBOutlet weak var timeOutwardJourneyView: UIView!
    @IBOutlet weak var timeOutwardJourneylbl: UILabel!
    @IBOutlet weak var timeOutJourneyValuelbl: UILabel!
    @IBOutlet weak var timeReturnJourneyView: UIView!
    @IBOutlet weak var timeReturnJourneylbl: UILabel!
    @IBOutlet weak var timeReturnJourneyValuelbl: UILabel!
    @IBOutlet weak var airlineView: UIView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var airlineValuelbl: UILabel!
    
    @IBOutlet weak var moreOptionImg: UIImageView!
    @IBOutlet weak var moreOptionlbl: UILabel!
    @IBOutlet weak var radio1View: UIView!
    @IBOutlet weak var radioReturnJourneylbl: UILabel!
    @IBOutlet weak var radioImg1: UIImageView!
    @IBOutlet weak var radio2View: UIView!
    @IBOutlet weak var radioDirectFlightlbl: UILabel!
    @IBOutlet weak var radioImg2: UIImageView!
    @IBOutlet weak var searchFlightsBtnView: UIView!
    @IBOutlet weak var searchFlightsBtnlbl: UILabel!
    @IBOutlet weak var searchFlightBtn: UIButton!
    
    var delegate:SearchFlightsTVCellDelegate?
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
     
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Select City"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Select City"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Departure Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "Add Traveller Details"

                returnView.isHidden = true
            }else {
                fromCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "Select City"
                toCitylbl.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "Select City"
                self.departureDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "+ Add Departure Date"
                self.returnDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "+ Add Return Date"
                economyValuelbl.text = defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "Add Traveller Details"

                returnView.isHidden = false
            }
        }
        
    }
    
    func setupUI() {
        
        swipeImage.image = UIImage(named: "swipe")
        dropdownImg.image = UIImage(named: "downarrow")
        moreOptionImg.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppTabSelectColor)

        
        setupViews(v: holderView, radius: 5, color: .WhiteColor)
        setupViews(v: fromView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: toView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: swipeView, radius: 20, color: .AppHolderViewColor)
        setupViews(v: departureView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: returnView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: economyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: moreExpandView, radius: 0, color: .WhiteColor)
        setupViews(v: timeOutwardJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: timeReturnJourneyView, radius: 4, color: .AppHolderViewColor)
        setupViews(v: airlineView, radius: 4, color: .AppHolderViewColor)
        moreExpandViewHeight.constant = 0
        
        setupLabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: fromCitylbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: toCitylbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: departurelbl, text: "Departure ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: departureDatelbl, text: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Departur Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: returnlbl, text: "Return ", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: returnDatelbl, text: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "+ Add Return Date", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: economylbl, text: "Travellers &  class", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: economyValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        
        setupLabels(lbl: timeOutwardJourneylbl, text: "Time Of Outward Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeOutJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: timeReturnJourneylbl, text: "Time Of Return Journey", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: timeReturnJourneyValuelbl, text: "All Times", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        setupLabels(lbl: airlinelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: airlineValuelbl, text: "Airline", textcolor: .AppLabelColor, font: .LatoSemibold(size: 18))
        
        setupLabels(lbl: moreOptionlbl, text: "More search options", textcolor: .AppTabSelectColor, font: .LatoMedium(size: 16))
        
        moreBtnHolderView.backgroundColor = .clear
        moreBtnHolderView.addBottomBorderWithColor(color: .AppTabSelectColor, width: 1)
        
        radio1View.backgroundColor = .clear
        radio2View.backgroundColor = .clear
        radioImg1.image = UIImage(named: "uncheck")
        radioImg2.image = UIImage(named: "uncheck")
        
        setupLabels(lbl: radioReturnJourneylbl, text: "Return journey from another location", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: radioDirectFlightlbl, text: "Direct flights only", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: searchFlightsBtnlbl, text: "Search Flight", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        setupViews(v: searchFlightsBtnView, radius: 4, color: .AppBtnColor)
        
        
        searchFlightBtn.setTitle("", for: .normal)
        returnView.isHidden = true
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @IBAction func didTapOnFromCityBtnAction(_ sender: Any) {
        delegate?.didTapOnFromCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnToCityBtnAction(_ sender: Any) {
        delegate?.didTapOnToCityBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSwipeCityBtnAction(_ sender: Any) {
        delegate?.didTapOnSwipeCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnDepartureBtnAction(_ sender: Any) {
        delegate?.didTapOnDepartureBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnReturnBtnAction(_ sender: Any) {
        delegate?.didTapOnReturnBtnAction(cell: self)
    }
    
    
    @IBAction func addEconomyBtnAction(_ sender: Any) {
        delegate?.addEconomyBtnAction(cell: self)
    }
    
    @IBAction func moreOptionBtnAction(_ sender: Any) {
        print("moreOptionBtnAction")
        delegate?.moreOptionBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeOutwardJourneyBtnAction(_ sender: Any) {
        delegate?.didTapOntimeOutwardJourneyBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOntimeReturnJourneyBtnAction(_ sender: Any) {
        delegate?.didTapOntimeReturnJourneyBtnAction(cell: self)
    }
    
    @IBAction func didTapOnairlineBtnAction(_ sender: Any) {
        delegate?.didTapOnairlineBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnReturnJurneyRadioButton(_ sender: Any) {
        delegate?.didTapOnReturnJurneyRadioButton(cell: self)
    }
    
    
    @IBAction func didTapOnDirectFlightRadioButton(_ sender: Any) {
        delegate?.didTapOnDirectFlightRadioButton(cell: self)
    }
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnSearchFlightBtnAction(cell: self)
    }
    
}

