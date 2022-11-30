//
//  MultiCityTripFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 11/08/22.
//

import UIKit
protocol MultiCityTripFlightResultTVCellDelegate {
    func gotoRoundTripBaggageIntoVC(cell:MultiCityTripFlightResultTVCell)
}

class MultiCityTripFlightResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinesLogoImg: UIImageView!
    @IBOutlet weak var airlinesNamelbl: UILabel!
    @IBOutlet weak var airlineCodelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var multiCityTripTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:MultiCityTripFlightResultTVCellDelegate?
    var arrayCount = Int()
    var totalPrice = String()
    var selectedResult = String()
    var taxes = String()
    var APICurrencyType = String()
    var kwdPrice = String()
    var mflight_details : MCFlight_details?
    
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
        
        selectedResult = cellInfo?.TotalQuestions ?? ""
        taxes = cellInfo?.questionBase ?? ""
        APICurrencyType = cellInfo?.questionType ?? ""
        kwdPrice = cellInfo?.headerText ?? ""
        
        self.mflight_details = cellInfo?.moreData as? MCFlight_details
        arrayCount = self.mflight_details?.summary?.count ?? 0
        tvHeight.constant = CGFloat((arrayCount * 70) - 20)
        
        multiCityTripTV.reloadData()
    }
    
    func setupUI() {
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        airlinesLogoImg.contentMode = .scaleToFill
        airlinesLogoImg.image = UIImage(named: "logo")
        setupLabels(lbl: airlinesNamelbl, text: "", textcolor: .AppLabelColor, font: .LatoRegular(size: 12))
        setupLabels(lbl: airlineCodelbl, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 10))
        setupLabels(lbl: datelbl, text: "", textcolor: .AppLabelColor, font: .LatoLight(size: 10))
        
        setupTV()
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupTV() {
        multiCityTripTV.register(UINib(nibName: "MCTripFlightTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        multiCityTripTV.delegate = self
        multiCityTripTV.dataSource = self
        multiCityTripTV.tableFooterView = UIView()
        multiCityTripTV.showsVerticalScrollIndicator = false
        multiCityTripTV.showsHorizontalScrollIndicator = false
        multiCityTripTV.isScrollEnabled = false

        multiCityTripTV.separatorStyle = .none
    }
    
    func gotoRoundTripBaggageIntoVC() {
        delegate?.gotoRoundTripBaggageIntoVC(cell: self)
    }
}


extension MultiCityTripFlightResultTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MCTripFlightTVCell {
            cell.selectionStyle = .none
            
            let data = mflight_details?.summary?[indexPath.row]
            
            airlinesNamelbl.text = data?.operator_name
            airlineCodelbl.text = "(\(data?.operator_code ?? ""))"
            datelbl.text = "22-10-22"
            
            if indexPath.row == 0 {
                cell.kwdPricelbl.isHidden = false
                cell.kwdPricelbl.text = cellInfo?.title ?? "0"
                cell.perPersonlbl.text = "Per Person"
            }else {
                cell.kwdPricelbl.isHidden = true
                cell.perPersonlbl.text = data?.origin?.date
            }
            
            cell.fromCityShortlbl.text = data?.origin?.loc
            cell.fromCityTimelbl.text = data?.origin?.time
            cell.toCityShortlbl.text = data?.destination?.loc
            cell.toCityTimelbl.text = data?.destination?.time
            cell.hourslbl.text = data?.duration
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoRoundTripBaggageIntoVC()
    }
    
}
