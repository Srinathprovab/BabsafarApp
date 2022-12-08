//
//  FlightDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit
import SDWebImage
protocol FlightDetailsTVCellDelegate {
    func didTapOnViewFlightsDetailsBtn(cell:FlightDetailsTVCell)
    func didTapOnFlightsDetails(cell:SearchFlightResultTVCell)
}

class FlightDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var flightDetailsTV: UITableView!
    @IBOutlet weak var flightDetailsTVHeight: NSLayoutConstraint!
    var delegate:FlightDetailsTVCellDelegate?
    var key = String()
    var index = Int()
    var mbdetails:[MBdetails]?
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
        
        mbdetails = cellInfo?.moreData as? [MBdetails]
        flightDetailsTVHeight.constant = CGFloat((mbdetails?.count ?? 0) * 100)
        self.flightDetailsTV.reloadData()
    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupTV()
    }
    
    func setupTV() {
        flightDetailsTVHeight.constant = 120
        flightDetailsTV.register(UINib(nibName: "BookFlightDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDetailsTV.delegate = self
        flightDetailsTV.dataSource = self
        flightDetailsTV.tableFooterView = UIView()
        flightDetailsTV.separatorStyle = .none
        flightDetailsTV.showsHorizontalScrollIndicator = false
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
}


extension FlightDetailsTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mbdetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookFlightDetailsTVCell {
            cell.selectionStyle = .none
            
            
            let data = mbdetails?[indexPath.row]
            cell.fromtimelbl.text = data?.origin?.time
            cell.fromCityShortlbl.text = data?.origin?.city
            cell.totimelbl.text = data?.destination?.time
            cell.toCityShortlbl.text = data?.destination?.city
            cell.hourslbl.text = data?.duration
            cell.noStopslbl.text = "no of stops \(String(data?.no_of_stops ?? 0))"
            cell.airwaysLogoImg.sd_setImage(with: URL(string: data?.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.titlelbl.text = "\(data?.operator_name ?? "")(\(data?.operator_code ?? ""))"
            
            
            ccell = cell
        }
        
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultTVCell{
            delegate?.didTapOnFlightsDetails(cell: cell)
        }
        
    }
    
}
