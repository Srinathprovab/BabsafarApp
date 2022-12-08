//
//  CancellationFeesTVCell.swift
//  BabSafar
//
//  Created by FCI on 02/12/22.
//

import UIKit

class CancellationFeesTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var Cancellationfeeslbl: UILabel!
    @IBOutlet weak var sectorView1: UIView!
    @IBOutlet weak var sectorlbl1: UILabel!
    @IBOutlet weak var airlinefeeslbl1: UILabel!
    @IBOutlet weak var airportcodelbl1: UILabel!
    @IBOutlet weak var CancellationKWDlbl1: UILabel!
    @IBOutlet weak var Adminchargeslbl1: UILabel!
    @IBOutlet weak var KWDpassengerlbl1: UILabel!
    @IBOutlet weak var datechanhefeelbl: UILabel!
    @IBOutlet weak var sectorView2: UIView!
    @IBOutlet weak var sectorlbl2: UILabel!
    @IBOutlet weak var airlinefeeslbl2: UILabel!
    @IBOutlet weak var airportcodelbl2: UILabel!
    @IBOutlet weak var CancellationKWDlbl2: UILabel!
    @IBOutlet weak var Adminchargeslbl2: UILabel!
    @IBOutlet weak var KWDpassengerlbl2: UILabel!
    @IBOutlet weak var chargesinfolbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: Cancellationfeeslbl, text: "Cancellation fees:", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        sectorView1.backgroundColor = HexColor("#00A898")
        sectorView2.backgroundColor = HexColor("#00A898")
        setuplabels(lbl: sectorlbl1, text: "Sector", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: airlinefeeslbl1, text: "Airline Fees", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: airportcodelbl1, text: "kWI - IST", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: CancellationKWDlbl1, text: "KWD 51.087 for cancellations done before the departure of the first flight.", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: Adminchargeslbl1, text: "Admin charges", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: KWDpassengerlbl1, text: "KWD 10 per passenger", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: airportcodelbl2, text: "kWI - IST", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: CancellationKWDlbl2, text: "KWD 51.087 for cancellations done before the departure of the first flight.", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14), align: .left)
        
        setuplabels(lbl: sectorlbl2, text: "Sector", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: airlinefeeslbl2, text: "Airline Fees", textcolor: .WhiteColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: Adminchargeslbl2, text: "Admin charges", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
        setuplabels(lbl: KWDpassengerlbl2, text: "KWD 10 per passenger", textcolor: HexColor("#808089"), font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: chargesinfolbl, text: "charges are prior to scheduled departure of the first flight.Does not include additio  no-show charges.", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .left)
        setuplabels(lbl: datechanhefeelbl, text: "Date Chanhe Fee:", textcolor: .AppLabelColor, font: .LatoSemibold(size: 14), align: .left)
    }
    
    
}
