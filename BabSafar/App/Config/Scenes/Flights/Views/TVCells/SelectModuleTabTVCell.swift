//
//  SelectModuleTabTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/03/23.
//

import UIKit

protocol SelectModuleTabTVCellDelegate {
    func didTapOnFlightBtnAction(cell:SelectModuleTabTVCell)
    func didTapOnHotelBtnAction(cell:SelectModuleTabTVCell)
    func didTapOnVisaBtnAction(cell:SelectModuleTabTVCell)
    
    func didTapOnMenuBtn(cell:SelectModuleTabTVCell)
    func didTapOnCurrencyBtn(cell:SelectModuleTabTVCell)

    
}

class SelectModuleTabTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    //   @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var flightlbl: UILabel!
    @IBOutlet weak var hotellbl: UILabel!
    @IBOutlet weak var visalbl: UILabel!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var flightImg: UIImageView!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var hoteltImg: UIImageView!
    @IBOutlet weak var hotelBtn: UIButton!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var visatImg: UIImageView!
    @IBOutlet weak var visaBtn: UIButton!
    @IBOutlet weak var btnsView: UIView!
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langimg: UIImageView!
    @IBOutlet weak var downarrowimg: UIImageView!
    
    
    var delegate:SelectModuleTabTVCellDelegate?
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
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(currencyset), name: Notification.Name("currency"), object: nil)
        
    }
    
    @objc func currencyset() {
        langlbl.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .black.withAlphaComponent(0.0)
        holderView.backgroundColor = .AppHolderViewColor
        langimg.image = UIImage(named: "currency")?.withRenderingMode(.alwaysOriginal)
        btnsView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        //bannerImage.isHidden = true
        flightImg.image = UIImage(named: "tn1")
        hoteltImg.image = UIImage(named: "tn2")
        visatImg.image = UIImage(named: "tn3")
        setuplabels(lbl: langlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD")", textcolor: .WhiteColor, font: .LatoBold(size: 14), align: .left)
        setuplabels(lbl: flightlbl, text: "Flight", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: hotellbl, text: "Hotel", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: visalbl, text: "Visa", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .center)
        flightBtn.addTarget(self, action: #selector(didTapOnFlightBtnAction(_:)), for: .touchUpInside)
        hotelBtn.addTarget(self, action: #selector(didTapOnHotelBtnAction(_:)), for: .touchUpInside)
        visaBtn.addTarget(self, action: #selector(didTapOnVisaBtnAction(_:)), for: .touchUpInside)
        flightBtn.setTitle("", for: .normal)
        hotelBtn.setTitle("", for: .normal)
        visaBtn.setTitle("", for: .normal)
        flightView.backgroundColor = .WhiteColor
        flightView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 6)
        hotelView.backgroundColor = .WhiteColor
        hotelView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 6)
        visaView.backgroundColor = .WhiteColor
        visaView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 6)
        
        
        downarrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
    @objc func didTapOnFlightBtnAction(_ sender:UIButton){
        //flightTap()
        delegate?.didTapOnFlightBtnAction(cell: self)
    }
    
    func flightTap() {
        self.flightImg.image = UIImage(named: "tn1")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        self.hoteltImg.image = UIImage(named: "tn2")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.visatImg.image = UIImage(named: "tn3")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.flightView.backgroundColor = .AppTabSelectColor
        self.hotelView.backgroundColor = .WhiteColor
        self.visaView.backgroundColor = .WhiteColor
    }
    
    @objc func didTapOnHotelBtnAction(_ sender:UIButton){
       // hotelTap()
        delegate?.didTapOnHotelBtnAction(cell: self)
    }
    
    func hotelTap() {
        self.flightImg.image = UIImage(named: "tn1")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.hoteltImg.image = UIImage(named: "tn2")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        self.visatImg.image = UIImage(named: "tn3")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.flightView.backgroundColor = .WhiteColor
        self.hotelView.backgroundColor = .AppTabSelectColor
        self.visaView.backgroundColor = .WhiteColor
    }
    
    @objc func didTapOnVisaBtnAction(_ sender:UIButton){
       // visaTap()
        delegate?.didTapOnVisaBtnAction(cell: self)
    }
    
    
    func visaTap() {
        self.flightImg.image = UIImage(named: "tn1")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.hoteltImg.image = UIImage(named: "tn2")?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
        self.visatImg.image = UIImage(named: "tn3")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        self.flightView.backgroundColor = .WhiteColor
        self.hotelView.backgroundColor = .WhiteColor
        self.visaView.backgroundColor = .AppTabSelectColor
    }
    
    @IBAction func didTapOnMenuBtn(_ sender: Any) {
        delegate?.didTapOnMenuBtn(cell: self)
    }
    
    @IBAction func didTapOnCurrencyBtn(_ sender: Any) {
        delegate?.didTapOnCurrencyBtn(cell: self)
    }
    
}
