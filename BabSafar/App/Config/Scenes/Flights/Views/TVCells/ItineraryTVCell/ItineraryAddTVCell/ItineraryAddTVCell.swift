//
//  ItineraryAddTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//

import UIKit

class ItineraryAddTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var additneraryTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var depFind = Int()
    var fdetais = [FDFlightDetails]()
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
        depFind = Int(cellInfo?.title ?? "") ?? 0
        fdetais = cellInfo?.moreData as! [FDFlightDetails]
        tvHeight.constant = CGFloat((fdetais.count * 250))
        additneraryTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        setupTV()
    }
    
    
    func setupTV() {
        additneraryTV.register(UINib(nibName: "ItineraryTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        additneraryTV.delegate = self
        additneraryTV.dataSource = self
        additneraryTV.tableFooterView = UIView()
        additneraryTV.showsVerticalScrollIndicator = false
        additneraryTV.separatorStyle = .none
        additneraryTV.isScrollEnabled = false
    }
    
}




extension ItineraryAddTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetais.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ItineraryTVCell {
            
            let data = fdetais[indexPath.row]
            cell.title1lbl.text = "\(data.operator_name ?? "") (\(data.operator_code ?? "") \(data.flight_number ?? ""))"
            cell.cityTolbl.text = "\(data.origin?.city ?? "") to \(data.destination?.city ?? "")"
            cell.arivalTime.text = "\(data.origin?.time ?? "")"
            cell.arivalDate.text = "\(data.origin?.date ?? "")"
            cell.airportlbl.text = "\(data.origin?.airport_name ?? "")"
            cell.terminal1lbl.text = "Terminal: \(data.origin?.terminal ?? "0")"
            
            cell.hourlbl1.text = data.duration
            cell.destTime.text = "\(data.destination?.time ?? "")"
            cell.destDate.text = "\(data.destination?.date ?? "")"
            cell.destlbl.text = "\(data.destination?.airport_name ?? "")"
            cell.destTerminal1lbl.text = "Terminal: \(data.destination?.terminal ?? "0")"
            
            if tableView.isLast(for: indexPath) {
                cell.timeView.isHidden = true
               
            }
            
            cell.airwaysImg1.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage: UIImage(contentsOfFile: "placeholder.png"))
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    if indexPath.row == 0 {
                        cell.deplbl.isHidden = false
                        cell.flightImg.isHidden = false
                        cell.flightImg.image = UIImage(named: "dep")
                        cell.deplbl.text = "Departure"
                    }
                } else {
                    if indexPath.row == 0 {
                        if depFind == indexPath.row {
                            cell.deplbl.isHidden = false
                            cell.flightImg.isHidden = false
                            cell.deplbl.text = "Departure"
                            cell.flightImg.image = UIImage(named: "dep")
                        } else {
                            cell.deplbl.isHidden = false
                            cell.flightImg.isHidden = false
                            cell.deplbl.text = "Return"
                            cell.flightImg.image = UIImage(named: "arrival")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
                        }
                    }
                }
            }
            
            cell.economylbl.text = data.cabin_class ?? ""
            
            var totalDuration: TimeInterval = 0
            var totalLayoverTime: TimeInterval = 0
            
            for i in 0..<fdetais.count {
                let flight = fdetais[i]
                if let duration = flight.duration {
                    totalDuration += parseFlightDuration(duration)
                }
                
                if i < fdetais.count - 1 {
                    let currentFlight = fdetais[i]
                    let nextFlight = fdetais[i + 1]
                    if let layoverTime = addAllDurationandLayoverTime(startDateString: currentFlight.destination?.datetime ?? "", endDateString: nextFlight.origin?.datetime ?? "") {
                        totalLayoverTime += layoverTime
                    }
                }
            }
            
            let totalJourneyTime = totalDuration + totalLayoverTime
           // cell.totalJourneyTimelbl.text = "Total Journey Time: \(formatDuration(totalJourneyTime))"
            
            if fdetais.count <= 1 {
                cell.hourlbl1.text = "\(data.duration ?? "")"
            } else {
                cell.hourlbl1.text = "\(data.duration ?? "")"
                
                if indexPath.row < fdetais.count - 1 {
                    let currentFlight = fdetais[indexPath.row]
                    let nextFlight = fdetais[indexPath.row + 1]
                    
                    if let layoverTime = calculateLayoverTime(startDateString: currentFlight.destination?.datetime ?? "", endDateString: nextFlight.origin?.datetime ?? "") {
                        cell.timelbl.text = "Layover Duration \(nextFlight.origin?.city ?? "") (\(nextFlight.origin?.loc ?? "")) \(layoverTime)"
                    } else {
                        print("Could not calculate layover time")
                        cell.timelbl.text = "Layover Duration: N/A"
                    }
                } else {
                    cell.timelbl.text = ""
                }
            }
            
            c = cell
        }
        return c
    }


    func calculateLayoverTime(startDateString: String, endDateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let startDate = dateFormatter.date(from: startDateString),
              let endDate = dateFormatter.date(from: endDateString) else {
            print("Invalid date format")
            return nil
        }
        
        let layoverInterval = endDate.timeIntervalSince(startDate)
        let layoverHours = Int(layoverInterval) / 3600
        let layoverMinutes = (Int(layoverInterval) % 3600) / 60
        
        return String(format: "%02dh %02dm", layoverHours, layoverMinutes)
    }
    
    
    
    
    func formatDuration(_ totalSeconds: TimeInterval) -> String {
        let hours = Int(totalSeconds) / 3600
        let minutes = (Int(totalSeconds) % 3600) / 60
        return String(format: "%02dh %02dm", hours, minutes)
    }
    
    
    func parseFlightDuration(_ duration: String) -> TimeInterval {
        let components = duration.split(separator: " ")
        var totalSeconds: TimeInterval = 0
        
        for component in components {
            if component.hasSuffix("h") {
                if let hours = Double(component.dropLast()) {
                    totalSeconds += hours * 3600
                }
            } else if component.hasSuffix("m") {
                if let minutes = Double(component.dropLast()) {
                    totalSeconds += minutes * 60
                }
            }
        }
        return totalSeconds
    }
    
    
    
    
    func addAllDurationandLayoverTime(startDateString: String, endDateString: String) -> TimeInterval? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let startDate = dateFormatter.date(from: startDateString),
              let endDate = dateFormatter.date(from: endDateString) else {
            print("Invalid date format")
            return nil
        }
        
        return endDate.timeIntervalSince(startDate)
    }


    
}
