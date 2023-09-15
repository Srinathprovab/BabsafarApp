//
//  PriceSummaryTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

protocol PriceSummaryTVCellDelegate {
    func didTapOnRemoveTravelInsuranceBtn(cell:PriceSummaryTVCell)
}

class PriceSummaryTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var psImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tvHolderView: UIView!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var totalPaymentlbl: UILabel!
    @IBOutlet weak var totalPaymentValuelbl: UILabel!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var travellerAdultTV: UITableView!
    
    var delegate:PriceSummaryTVCellDelegate?
    var key = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        self.key =  cellInfo?.key ?? ""
        
        
        setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                             str2: String(format: "%.2f", Double(cellInfo?.price ?? "") ?? 0.0),
                             lbl: totalPaymentValuelbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            
            if selectedTab == "Flights" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        
                        
                        
                    }else if journeyType == "circle"{
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
                    }else {
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
                    }
                }
                
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
                
            }
        }
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0{
            tvheight.constant = 115
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0{
            tvheight.constant = 115 * 2
        }else {
            tvheight.constant = 115 * 3
        }
        
        
        
    }
    
    func setupUI(){
        
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: ulView, radius: 0, color: .clear)
        
        psImg.image = UIImage(named:"pricesummery")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "Price Summary", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: totalPaymentlbl, text: "Total Trip Cost", textcolor: .IttenarySelectedColor, font: .LatoBold(size: 18))
        
    }
    
    func setupTV() {
        tvheight.constant = 342
        let nib = UINib(nibName: "TravellerAdultTVCell", bundle: nil)
        travellerAdultTV.register(nib, forCellReuseIdentifier: "cell")
        travellerAdultTV.delegate = self
        travellerAdultTV.dataSource = self
        travellerAdultTV.isScrollEnabled = false
        travellerAdultTV.showsHorizontalScrollIndicator = false
        travellerAdultTV.tableFooterView = UIView()
        travellerAdultTV.separatorStyle = .none
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
    
    
}


extension PriceSummaryTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if adultsCount > 0 && childCount == 0 && infantsCount == 0{
            return 1
        }else if adultsCount > 0 && childCount > 0 && infantsCount == 0{
            return 2
        }else {
            return 3
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TravellerAdultTVCell {
            cell.selectionStyle = .none
            
            
            if indexPath.row == 0 {
                cell.adultCountlbl.text = "Traveller x \(adultsCount)(Adult)"
                
                //                cell.adultKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(AdultsTotalPrice) ?? 0.0))"
                //                cell.fareKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Adults_Base_Price) ?? 0.0))"
                //                cell.taxesKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Adults_Tax_Price) ?? 0.0))"
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(AdultsTotalPrice) ?? 0.0),
                                     lbl: cell.adultKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Adults_Base_Price) ?? 0.0),
                                     lbl: cell.fareKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Adults_Tax_Price) ?? 0.0),
                                     lbl: cell.taxesKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
            }else if indexPath.row == 1 {
                cell.adultCountlbl.text = "Traveller x \(childCount)(Child)"
                //                cell.adultKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(ChildTotalPrice) ?? 0.0))"
                //                cell.fareKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Childs_Base_Price) ?? 0.0))"
                //                cell.taxesKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Childs_Tax_Price) ?? 0.0))"
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(ChildTotalPrice) ?? 0.0),
                                     lbl: cell.adultKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Childs_Base_Price) ?? 0.0),
                                     lbl: cell.fareKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Childs_Tax_Price) ?? 0.0),
                                     lbl: cell.taxesKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
            }else {
                cell.adultCountlbl.text = "Traveller x \(infantsCount)(Infanta)"
                //                cell.adultKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(InfantTotalPrice) ?? 0.0))"
                //                cell.fareKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Infants_Base_Price) ?? 0.0))"
                //                cell.taxesKWDlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(String(format: "%.2f", Double(Infants_Tax_Price) ?? 0.0))"
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(InfantTotalPrice) ?? 0.0),
                                     lbl: cell.adultKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Infants_Base_Price) ?? 0.0),
                                     lbl: cell.fareKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
                
                setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                                     str2: String(format: "%.2f", Double(Infants_Tax_Price) ?? 0.0),
                                     lbl: cell.taxesKWDlbl,
                                     str1font: .LatoBold(size: 12),
                                     str2font: .LatoBold(size: 16),
                                     str1Color: .AppLabelColor,
                                     str2Color: .AppLabelColor)
                
            }
            
            
            
            if self.key == "hotel"  {
                cell.farelbl.text = ""
                cell.fareKWDlbl.text = ""
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
}
