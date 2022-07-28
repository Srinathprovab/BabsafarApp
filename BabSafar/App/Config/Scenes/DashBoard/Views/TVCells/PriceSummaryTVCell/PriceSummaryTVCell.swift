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
    @IBOutlet weak var travelInsuranceView: UIView!
    @IBOutlet weak var totalAmountlbl: UILabel!
    @IBOutlet weak var totalAmountValuelbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var totalPaymentlbl: UILabel!
    @IBOutlet weak var totalPaymentValuelbl: UILabel!
    @IBOutlet weak var travelInsurancelbl: UILabel!
    @IBOutlet weak var personalAccidentlbl: UILabel!
    @IBOutlet weak var tripDelaylbl: UILabel!
    @IBOutlet weak var kwdValuelbl: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var travellerAdultTV: UITableView!
    
    var delegate:PriceSummaryTVCellDelegate?
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
    
    func setupUI(){
        contentView.backgroundColor = .AppBorderColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: ulView, radius: 0, color: .AppBorderColor)
        setupViews(v: travelInsuranceView, radius: 4, color: HexColor("#00A898", alpha: 0.10))
        
        psImg.image = UIImage(named:"pricesummery")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "Price Summary", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: totalAmountlbl, text: "Total Amount", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: totalAmountValuelbl, text: "kWD :1,100.00", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: totalPaymentlbl, text: "Total Payment", textcolor: .AppLabelColor, font: .LatoBold(size: 14))
        setupLabels(lbl: totalPaymentValuelbl, text: "kWD :1,100.00", textcolor: .AppLabelColor, font: .LatoBold(size: 14))
        setupLabels(lbl: travelInsurancelbl, text: "Travel Insurance", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: personalAccidentlbl, text: "Personal Accident", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: tripDelaylbl, text: "Trip Delay", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        setupLabels(lbl: kwdValuelbl, text: "kWD :120.00", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        
        
        removeBtn.setTitle("Remove", for: .normal)
        removeBtn.setTitleColor(.AppTabSelectColor, for: .normal)
        removeBtn.titleLabel?.font = UIFont.LatoSemibold(size: 12)
        
        
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
    
    
    
    @IBAction func didTapOnRemoveTravelInsuranceBtn(_ sender: Any) {
        delegate?.didTapOnRemoveTravelInsuranceBtn(cell: self)
    }
    
}


extension PriceSummaryTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TravellerAdultTVCell {
            cell.selectionStyle = .none
            commonCell = cell
        }
        return commonCell
    }
    
    
}
