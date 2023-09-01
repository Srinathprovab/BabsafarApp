//
//  BCFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import UIKit
import SDWebImage

class BCFlightDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var flightDetaillsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var bookingFlightDetails = [Booking_itinerary_summary]()
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
        bookingFlightDetails = cellInfo?.moreData as? [Booking_itinerary_summary] ?? []
        tvHeight.constant = CGFloat(bookingFlightDetails.count * 182)
        flightDetaillsTV.reloadData()
    }
    
    func setupUI() {
        setupTV()
    }
    
    
    
}



extension BCFlightDetailsTVCell: UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "BCFlightInfoTVCell", bundle: nil)
        flightDetaillsTV.register(nib, forCellReuseIdentifier: "cell")
        flightDetaillsTV.delegate = self
        flightDetaillsTV.dataSource = self
        flightDetaillsTV.tableFooterView = UIView()
        flightDetaillsTV.separatorStyle = .none
        flightDetaillsTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingFlightDetails.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BCFlightInfoTVCell {
            cell.selectionStyle = .none
            
            let data = bookingFlightDetails[indexPath.row]
            cell.showLayover()
            cell.img.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

            cell.airlineNamelbl.text = data.operator_name ?? ""
            cell.flightNolbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.durationlbl.text = data.duration ?? ""
            cell.economylbl.text = data.cabin_class ?? ""
          
            cell.fromTimelbl.text = data.origin?.time ?? ""
            cell.fromCitylbl.text = data.origin?.airport_name ?? ""
            cell.fromdatelbl.text = data.origin?.date ?? ""
            
            
            cell.toTimelbl.text = data.destination?.time ?? ""
            cell.tocitylbl.text = data.destination?.airport_name ?? ""
            cell.todatelbl.text = data.destination?.date ?? ""

            cell.fromTerminallbl.text = "Terminal \(data.origin?.terminal ?? "")"
            cell.toTerminallbl.text = "Terminal \(data.destination?.terminal ?? "")"
            
            cell.layoverTimelbl.text = "Layover \(data.destination?.airport_name ?? "") (\(data.destination?.loc ?? ""))\(data.weight_Allowance ?? "")"
            
            if indexPath.row != 0 {
                cell.hideLayover()
            }else {
                cell.showLayover()
            }
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
