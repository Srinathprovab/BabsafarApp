//
//  HotelPriceSummaryTVCell.swift
//  BabSafar
//
//  Created by FCI on 09/05/23.
//

import UIKit

class HotelPriceSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var roomtypelbl: UILabel!
    @IBOutlet weak var roomtypeValuelbl: UILabel!
    @IBOutlet weak var cancellationpolicylbl: UILabel!
    @IBOutlet weak var cancellationpolicyValuelbl: UILabel!
    @IBOutlet weak var noofadultslbl: UILabel!
    @IBOutlet weak var noofadultsValuelbl: UILabel!
    @IBOutlet weak var noofchildlbl: UILabel!
    @IBOutlet weak var noofchildValuelbl: UILabel!
    @IBOutlet weak var totalamountlbl: UILabel!
    @IBOutlet weak var totalamountValuelbl: UILabel!
    @IBOutlet weak var taxeslbl: UILabel!
    @IBOutlet weak var taxesValuelbl: UILabel!
    @IBOutlet weak var totalpaymentlbl: UILabel!
    @IBOutlet weak var totalpaymentValuelbl: UILabel!
    
    
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
        
        titlelbl.text = cellInfo?.title
        roomtypeValuelbl.text = cellInfo?.subTitle
        cancellationpolicyValuelbl.text = cellInfo?.buttonTitle
        noofadultsValuelbl.text = cellInfo?.text
        noofchildValuelbl.text = cellInfo?.tempText
        totalamountValuelbl.text = cellInfo?.key
        taxesValuelbl.text = cellInfo?.headerText
        totalpaymentValuelbl.text = cellInfo?.price
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "Price Summary", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: roomtypelbl, text: "Room Type", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: cancellationpolicylbl, text: "Cancellation Policy", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: noofadultslbl, text: "No Of  Adults", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: noofchildlbl, text: "No Of  Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: totalamountlbl, text: "Total Amount", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: taxeslbl, text: "Taxes", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: totalpaymentlbl, text: "Total Payment", textcolor: .AppLabelColor, font: .LatoBold(size: 14), align: .left)
        
        setuplabels(lbl: roomtypeValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: cancellationpolicyValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: noofadultsValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: noofchildValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: totalamountValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: taxesValuelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .right)
        setuplabels(lbl: totalpaymentValuelbl, text: "", textcolor: HexColor("#64276F"), font: .LatoBold(size: 14), align: .right)
       
        
    }
    
    
    
    
}
