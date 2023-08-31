//
//  RoundTripFlightResultTVCell.swift
//  BabSafar
//
//  Created by MA673 on 10/08/22.
//

import UIKit
protocol RoundTripFlightResultTVCellDelegate {
    func gotoRoundTripBaggageIntoVC(cell:RoundTripFlightResultTVCell)
    func didTapOnFlightDetailsBtn(cell:RoundTripFlightResultTVCell)
    func didTapOnBookNowBtn(cell:RoundTripFlightResultTVCell)
    
    func didTapOnSimilarFlightsBtnAction(cell:RoundTripFlightResultTVCell)
    
}

class RoundTripFlightResultTVCell: TableViewCell {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roundTripTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var displayPrice = String()
    var delegate:RoundTripFlightResultTVCellDelegate?
    var arrayCount = Int()
    var refundable:Bool?
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
        displayPrice = cellInfo?.title ?? ""
        selectedResult = cellInfo?.TotalQuestions ?? ""
        self.rflight_details = cellInfo?.moreData as? Flight_details
        arrayCount = rflight_details?.summary?.count ?? 0
        
        
        
        tvHeight.constant = CGFloat(arrayCount * 162)
        roundTripTV.reloadData()
        
    }
    
    func setupUI() {
        holderView.backgroundColor = .clear
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
        roundTripTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        roundTripTV.separatorStyle = .none
        roundTripTV.isScrollEnabled = false
    }
    
    func gotoRoundTripBaggageIntoVC() {
        delegate?.gotoRoundTripBaggageIntoVC(cell: self)
    }
    
    
    @objc func didTapOnFlightDetailsBtn(_ sender:UIButton) {
        delegate?.didTapOnFlightDetailsBtn(cell: self)
    }
    
    
    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
        delegate?.didTapOnBookNowBtn(cell: self)
    }
    
    @objc func didTapOnSimilarFlightsBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSimilarFlightsBtnAction(cell: self)
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
            cell.imagesHolderView.layer.cornerRadius = 0
            cell.imagesHolderView.clipsToBounds = true
            
            let data = rflight_details?.summary
            cell.titlelbl.text = "\(data?[indexPath.row].operator_name ?? "")(\(data?[indexPath.row].operator_code ?? "") \(data?[indexPath.row].flight_number ?? ""))"
            cell.airwaysLogoImg.sd_setImage(with: URL(string: "\(data?[indexPath.row].operator_image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.fromCityShortlbl.text = "\(data?[indexPath.row].origin?.city ?? "")(\(data?[indexPath.row].origin?.loc ?? ""))"
            cell.fromCityTimelbl.text = data?[indexPath.row].origin?.time
            cell.toCityShortlbl.text = "\(data?[indexPath.row].destination?.city ?? "")(\(data?[indexPath.row].destination?.loc ?? ""))"
            cell.toCityTimelbl.text = data?[indexPath.row].destination?.time
            cell.hourslbl.text = data?[indexPath.row].duration
            let no_of_stops = String(data?[indexPath.row].no_of_stops ?? 0)
            cell.noStopslbl.text = "\(no_of_stops) stops"
            cell.setAttributedString(str1:cellInfo?.price ?? "" , str2: cellInfo?.title ?? "")
            
            cell.bagWeightlbl.text = cell.convertToDesiredFormat(data?[indexPath.row].weight_Allowance ?? "")
            cell.airoplaneImg.image = UIImage(named: "airo1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            cell.setAttributedString1(str1: cellInfo?.price ?? "", str2: cellInfo?.headerText ?? "")

            if let similatFlights = cellInfo?.data as? [[RTJ_flight_list]], (similatFlights.count - 1) != 0 {
                setuplabels(lbl: cell.moreSimlarOptionlbl, text: "More similar options(\(similatFlights.count))", textcolor: .WhiteColor, font: .LatoRegular(size: 10), align: .right)
                cell.showSimilarlbl()
            }
            cell.imagesHolderView.backgroundColor = HexColor("#00A898")
            if indexPath.row == 0 {
               
                cell.imagesHolderColoerChange()
                if cellInfo?.key1 == "Refundable" {
                    setuplabels(lbl: cell.kwdPricelbl, text: cellInfo?.key1 ?? "", textcolor: HexColor("#2FA804"), font: .LatoRegular(size: 13), align: .center)
                }else {
                    setuplabels(lbl: cell.kwdPricelbl, text: cellInfo?.key1 ?? "", textcolor: .AppBtnColor, font: .LatoRegular(size: 13), align: .center)
                }
                
                cell.markuppricelbl.textColor = .WhiteColor
                cell.flightsDetailsBtnView.isHidden = true
                cell.bookNowView.backgroundColor = HexColor("#FFCC33")
                setuplabels(lbl: cell.bookNowlbl, text: "Flight Details", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)

                cell.bookNowBtn.addTarget(self, action: #selector(didTapOnFlightDetailsBtn(_:)), for: .touchUpInside)
                cell.airoplaneImg.image = UIImage(named: "airo2")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#00A898"))

                cell.moreSimlarOptionlbl.isHidden = true
                cell.similarimg.isHidden = true
                cell.hideSimilarlbl()
            }
            

            cell.refundablelbl.isHidden = true
            cell.viewVoucherBtn.isHidden = true
            cell.flightsDetailsBtnView.isHidden = true
            cell.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
            cell.similarBtn.addTarget(self, action: #selector(didTapOnSimilarFlightsBtnAction(_:)), for: .touchUpInside)

            
          
            
            
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  gotoRoundTripBaggageIntoVC()
    }
    
}
