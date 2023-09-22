//
//  NewHotelPriceSummeryTVCell.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import UIKit

class NewHotelPriceSummeryTVCell: TableViewCell {
    
    
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var hotelLoclbl: UILabel!
    @IBOutlet weak var checkinDatelbl: UILabel!
    @IBOutlet weak var checkoutDatelbl: UILabel!
    @IBOutlet weak var noofNightslbl: UILabel!
    @IBOutlet weak var roomTypelbl: UILabel!
    @IBOutlet weak var adultsCountlbl: UILabel!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        
        hotelNamelbl.text = cellInfo?.title ?? ""
        hotelLoclbl.text = cellInfo?.subTitle ?? ""
        checkinDatelbl.text = cellInfo?.text ?? ""
        checkoutDatelbl.text = cellInfo?.buttonTitle ?? ""
        
        noofNightslbl.text = cellInfo?.tempText ?? ""
        roomTypelbl.text = cellInfo?.headerText ?? ""
        adultsCountlbl.text = "No Of Adults: \(cellInfo?.TotalQuestions ?? "")"
        childCountlbl.text = "No Of Children: \(cellInfo?.questionBase ?? "")"
        
      
        setAttributedTextnew(str1: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")",
                             str2: String(format: "%.2f", Double(cellInfo?.price ?? "") ?? 0.0),
                             lbl: pricelbl,
                             str1font: .LatoBold(size: 12),
                             str2font: .LatoBold(size: 18),
                             str1Color: .IttenarySelectedColor,
                             str2Color: .IttenarySelectedColor)
        
    }
    
}
