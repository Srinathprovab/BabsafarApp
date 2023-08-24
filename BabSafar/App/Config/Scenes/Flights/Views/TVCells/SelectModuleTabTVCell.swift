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
    func didTapOnInsurentTabBtnAction(cell:SelectModuleTabTVCell)
    func didTapOnVisaBtnAction(cell:SelectModuleTabTVCell)
    func didTapOnMenuBtn(cell:SelectModuleTabTVCell)
    func didTapOnCurrencyBtn(cell:SelectModuleTabTVCell)
    func didTapOnFastTrackBtnAction(cell:SelectModuleTabTVCell)

}

class SelectModuleTabTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
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
        
        setuplabels(lbl: langlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD")", textcolor: .WhiteColor, font: .LatoBold(size: 14), align: .left)
        
        flightBtn.addTarget(self, action: #selector(didTapOnFlightBtnAction(_:)), for: .touchUpInside)
        hotelBtn.addTarget(self, action: #selector(didTapOnHotelBtnAction(_:)), for: .touchUpInside)
        visaBtn.addTarget(self, action: #selector(didTapOnVisaBtnAction(_:)), for: .touchUpInside)
        flightBtn.setTitle("", for: .normal)
        hotelBtn.setTitle("", for: .normal)
        visaBtn.setTitle("", for: .normal)
        
        downarrowimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
    @objc func didTapOnFlightBtnAction(_ sender:UIButton){
        delegate?.didTapOnFlightBtnAction(cell: self)
    }
    
    @objc func didTapOnHotelBtnAction(_ sender:UIButton){
        delegate?.didTapOnHotelBtnAction(cell: self)
    }
    
    
    @objc func didTapOnVisaBtnAction(_ sender:UIButton){
        // visaTap()
        delegate?.didTapOnVisaBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnMenuBtn(_ sender: Any) {
        delegate?.didTapOnMenuBtn(cell: self)
    }
    
    @IBAction func didTapOnCurrencyBtn(_ sender: Any) {
        delegate?.didTapOnCurrencyBtn(cell: self)
    }
    
    
    @IBAction func didTapOnInsurentTabBtnAction(_ sender: Any) {
        delegate?.didTapOnInsurentTabBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnFastTrackBtnAction(_ sender: Any) {
        delegate?.didTapOnFastTrackBtnAction(cell: self)
    }
    
    
}
