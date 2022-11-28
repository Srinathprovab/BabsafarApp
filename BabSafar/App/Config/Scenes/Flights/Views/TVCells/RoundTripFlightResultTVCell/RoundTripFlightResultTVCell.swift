//
//  RoundTripFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 10/08/22.
//

import UIKit
protocol RoundTripFlightResultTVCellDelegate {
    func gotoRoundTripBaggageIntoVC(cell:RoundTripFlightResultTVCell)
}

class RoundTripFlightResultTVCell: TableViewCell {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roundTripTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:RoundTripFlightResultTVCellDelegate?
    var arrayCount = Int()
    
    var rflight_details : Flight_details?
    var totalPrice = String()
    var selectedResult = String()
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
        
        totalPrice = cellInfo?.headerText ?? ""
        selectedResult = cellInfo?.TotalQuestions ?? ""
        //        taxes = cellInfo?.questionBase ?? ""
        //        APICurrencyType = cellInfo?.questionType ?? ""
        //
        //        kwdPrice = cellInfo?.title ?? ""
        
        self.rflight_details = cellInfo?.moreData as? Flight_details
        arrayCount = rflight_details?.summary?.count ?? 0
        tvHeight.constant = CGFloat(arrayCount * 136)
        roundTripTV.reloadData()
        
    }
    
    func setupUI() {
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        setupTV()
    }
    
    func setupTV() {
        roundTripTV.register(UINib(nibName: "SearchFlightResultTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roundTripTV.delegate = self
        roundTripTV.dataSource = self
        roundTripTV.tableFooterView = UIView()
        roundTripTV.showsHorizontalScrollIndicator = false
        roundTripTV.layer.cornerRadius = 10
        roundTripTV.clipsToBounds = true
        roundTripTV.layer.borderWidth = 1
        roundTripTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        roundTripTV.separatorStyle = .none
        roundTripTV.isScrollEnabled = false
    }
    
    func gotoRoundTripBaggageIntoVC() {
        delegate?.gotoRoundTripBaggageIntoVC(cell: self)
    }
}


extension RoundTripFlightResultTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rflight_details?.summary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchFlightResultTVCell {
            cell.selectionStyle = .none
            cell.holderViewTopConstraint.constant = 0
            cell.holderView.layer.cornerRadius = 0
            cell.holderView.clipsToBounds = true
            cell.holderView.layer.borderColor = UIColor.clear.cgColor
            
            let data = rflight_details?.summary
            cell.kwdPricelbl.text = self.totalPrice
            cell.titlelbl.text = "\(data?[indexPath.row].operator_name ?? "")(\(data?[indexPath.row].operator_code ?? ""))"
            cell.airwaysLogoImg.sd_setImage(with: URL(string: "\(data?[indexPath.row].operator_image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.fromCityShortlbl.text = "\(data?[indexPath.row].origin?.city ?? "")(\(data?[indexPath.row].origin?.loc ?? ""))"
            cell.fromCityTimelbl.text = data?[indexPath.row].origin?.time
            cell.toCityShortlbl.text = "\(data?[indexPath.row].destination?.city ?? "")(\(data?[indexPath.row].destination?.loc ?? ""))"
            cell.toCityTimelbl.text = data?[indexPath.row].destination?.time
            cell.hourslbl.text = data?[indexPath.row].duration
            let no_of_stops = String(data?[indexPath.row].no_of_stops ?? 0)
            cell.noStopslbl.text = "\(no_of_stops) stops"
          //  cell.bagWeightlbl.text = data?[indexPath.row].weight_Allowance
            
            if indexPath.row == 0 {
                cell.hidePerpersonLbl()
            }
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoRoundTripBaggageIntoVC()
    }
    
}
