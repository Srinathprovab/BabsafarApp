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
    
    
    var bookingFlightDetails = [Booking_itinerary_details]()
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
        bookingFlightDetails = cellInfo?.moreData as? [Booking_itinerary_details] ?? []
        tvHeight.constant = CGFloat(bookingFlightDetails.count * 124)
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
            cell.img.sd_setImage(with: URL(string: data.airline_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))

            cell.airlineNamelbl.text = data.airline_name ?? ""
            cell.flightNolbl.text = "(\(data.airline_code ?? "")-\(data.flight_number ?? ""))"
            cell.durationlbl.text = data.duration ?? ""
            cell.economylbl.text = data.cabin_class ?? ""
            
            cell.fromCitylbl.text = data.from_airport_name ?? ""
            cell.fromTimelbl.text = data.departure_time ?? ""
            cell.fromdatelbl.text = data.departure_date ?? ""
            
            cell.toTimelbl.text = data.arrival_time ?? ""
            cell.tocitylbl.text = data.to_airport_name ?? ""
            cell.todatelbl.text = data.arrival_date ?? ""

            cell.fromTerminallbl.text = "Terminal \(data.origin_terminal ?? "")"
            cell.toTerminallbl.text = "Terminal \(data.destination_terminal ?? "")"
            
            
            if indexPath.row == 0 {
                //cell.hideLayover()
            }
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
