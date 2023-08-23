//
//  NavBar.swift
//  AirportProject
//
//  Created by Codebele 09 on 21/06/22.
//

import UIKit
import Foundation

class NavBar: UIView {
    
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var filterBtnView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var airwaysLogoImg: UIImageView!
    @IBOutlet weak var airwaysTitlelbl: UILabel!
    @IBOutlet weak var sourceTimelbl: UILabel!
    @IBOutlet weak var sourceCitylbl: UILabel!
    @IBOutlet weak var destTimelbl: UILabel!
    @IBOutlet weak var destCitylbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var mainTabBtnsView: UIView!
    @IBOutlet weak var tabSelectionView: UIView!
    @IBOutlet weak var flightHolderView: UIView!
    @IBOutlet weak var flightimage: UIImageView!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var hotelHolderView: UIView!
    @IBOutlet weak var hotelimage: UIImageView!
    @IBOutlet weak var hotelBtn: UIButton!
    @IBOutlet weak var visaHolderView: UIView!
    @IBOutlet weak var visatimag: UIImageView!
    @IBOutlet weak var visaBtn: UIButton!
    @IBOutlet weak var lblFlight: UILabel!
    @IBOutlet weak var lblHotel: UILabel!
    @IBOutlet weak var lblVisa: UILabel!
    
    
    @IBOutlet weak var btnsHolderView: UIView!
    var image = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
        
        setupuiview()
    }
    
    
    func setupuiview(){
        
        btnsHolderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        contentView.backgroundColor = .AppHeadderBackColor
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width + 15, height: self.contentView.frame.height))
        image.image = UIImage(named: "baner")
        image.contentMode = .scaleToFill
        contentView.addSubview(image)
        
        backBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        backBtnView.layer.cornerRadius = 20
        backBtnView.clipsToBounds = true
        
        
        editBtnView.isHidden = true
        filterBtnView.isHidden = true
        lbl1.isHidden = true
        lbl2.isHidden = true
        
        editBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        editBtnView.layer.cornerRadius = 20
        editBtnView.clipsToBounds = true
        
        filterBtnView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        filterBtnView.layer.cornerRadius = 20
        filterBtnView.clipsToBounds = true
        
        leftArrowImg.image = UIImage(named: "leftarrow")
        filterImg.image = UIImage(named: "filter")
        editImg.image = UIImage(named: "edit1")
        
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.LatoMedium(size: 20)
        
        lbl1.textColor = .WhiteColor
        lbl1.font = UIFont.LatoMedium(size: 20)
        lbl2.textColor = .WhiteColor
        lbl2.font = UIFont.LatoRegular(size: 14)
        lbl1.textAlignment = .center
        lbl2.textAlignment = .center
        
        
        self.contentView.bringSubviewToFront(self.backBtnView)
        self.contentView.bringSubviewToFront(self.titlelbl)
        self.contentView.bringSubviewToFront(self.filterBtnView)
        self.contentView.bringSubviewToFront(self.editBtnView)
        self.contentView.bringSubviewToFront(self.lbl1)
        self.contentView.bringSubviewToFront(self.lbl2)
        
        
        view.isHidden = true
        view.backgroundColor = .clear
        contentView.bringSubviewToFront(view)
        airwaysLogoImg.image = UIImage(named: "airways")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: airwaysTitlelbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: sourceTimelbl, text: "", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        setupLabels(lbl: sourceCitylbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: destTimelbl, text: "", textcolor: .WhiteColor, font: .LatoSemibold(size: 20))
        setupLabels(lbl: destCitylbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: hourslbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: noOfStopslbl, text: "", textcolor: .WhiteColor, font: .LatoRegular(size: 12))
        
        mainTabBtnsView.isHidden = true
        flightimage.image = UIImage(named: "flight")
        hotelimage.image = UIImage(named: "hotel")
        visatimag.image = UIImage(named: "visa")
        
        setupViews(v: tabSelectionView, radius: 0, color: .WhiteColor.withAlphaComponent(0.5))
        setupViews(v: flightHolderView, radius: 6, color: .AppTabSelectColor)
        setupViews(v: hotelHolderView, radius: 6, color: .WhiteColor)
        setupViews(v: visaHolderView, radius: 6, color: .WhiteColor)
        
        setupLabels(lbl: lblFlight, text: "Flights", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: lblHotel, text: "Hotels", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: lblVisa, text: "Visa", textcolor: .WhiteColor, font: .LatoRegular(size: 14))
        
        contentView.bringSubviewToFront(mainTabBtnsView)
        editBtn.addTarget(self, action: #selector(didTapOnEditButton(_:)), for: .touchUpInside)
        
       
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
    
    @objc func didTapOnEditButton(_ sender:UIButton){
        print("didTapOnEditButton ==== ")
    }
    
    
    @IBAction func didTapOnBackBtn(_ sender: Any) {
        
    }
    
    @IBAction func searchFlightBtnAction(_ sender: Any) {
        
        flightHolderView.backgroundColor = .AppTabSelectColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
        hotelHolderView.backgroundColor = .WhiteColor
        hotelimage.image = UIImage(named: "hotel")
        
      
        
        visaHolderView.backgroundColor = .WhiteColor
        visatimag.image = UIImage(named: "visa")
        
    }
    
    @IBAction func searchHotelsBtnAction(_ sender: Any) {
        print("searchHotelsBtnAction")
        
        flightHolderView.backgroundColor = .WhiteColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImageDefaultColor)
        
        hotelHolderView.backgroundColor = .AppTabSelectColor
        hotelimage.image = UIImage(named: "hotel")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        
    
        
        visaHolderView.backgroundColor = .WhiteColor
        visatimag.image = UIImage(named: "visa")
    }
    
    
    @IBAction func searchVisaBtnAction(_ sender: Any) {
        print("searchVisaBtnAction")
        
        flightHolderView.backgroundColor = .WhiteColor
        flightimage.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImageDefaultColor)
        
        hotelHolderView.backgroundColor = .WhiteColor
        hotelimage.image = UIImage(named: "hotel")
        
             
        visaHolderView.backgroundColor = .AppTabSelectColor
        visatimag.image = UIImage(named: "visa")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
}



