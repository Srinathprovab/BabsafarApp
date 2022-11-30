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
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var flightImg: UIImageView!
    @IBOutlet weak var flightDetailsTV: UITableView!
    @IBOutlet weak var flightDetailsTVHeight: NSLayoutConstraint!
    @IBOutlet weak var viewFlightsDetailsBtnView: UIView!
    @IBOutlet weak var viewFlightsDetailslbl: UILabel!
    @IBOutlet weak var viewFlightsDetailsBtn: UIButton!
    @IBOutlet weak var topUL: UIView!
    @IBOutlet weak var bottomUL: UIView!
    
    @IBOutlet weak var flightImgHeight: NSLayoutConstraint!
    var delegate:FlightDetailsTVCellDelegate?
    var key = String()
    var index = Int()
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
        
        index = Int(defaults.string(forKey: UserDefaultsKeys.selectdFlightcellIndex) ?? "0") ?? 0
        
        print("indexindexindexindexindex === \(index)")
        
        
        if cellInfo?.key == "circle" {
            flightDetailsTVHeight.constant = CGFloat((RTFlightList?[index].count ?? 0) * 170)
        }else if cellInfo?.key == "oneway" {
            flightDetailsTVHeight.constant = CGFloat((FlightList?[index].count ?? 0) * 150)
        }else {
            flightDetailsTVHeight.constant = CGFloat((MCJflightlist?.count ?? 0) * 170)
        }
        
        self.flightDetailsTV.reloadData()
    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        setupViews(v: viewFlightsDetailsBtnView, radius: 15, color: HexColor("#FCEDFF"))
        flightImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppCalenderDateSelectColor)
        viewFlightsDetailsBtn.setTitle("", for: .normal)
        setupLabels(lbl: titlelbl, text: "Flight Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16))
        setupLabels(lbl: viewFlightsDetailslbl, text: "View Flights Details", textcolor: .AppLabelColor, font: .LatoRegular(size: 14))
        topUL.backgroundColor = HexColor("#CECECE")
        bottomUL.backgroundColor = HexColor("#CECECE")
        setupTV()
    }
    
    func setupTV() {
        flightDetailsTVHeight.constant = 120
        flightDetailsTV.register(UINib(nibName: "SearchFlightResultTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDetailsTV.register(UINib(nibName: "SearchFlightResultTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        flightDetailsTV.register(UINib(nibName: "MCTripFlightTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        
        
        flightDetailsTV.delegate = self
        flightDetailsTV.dataSource = self
        flightDetailsTV.tableFooterView = UIView()
        flightDetailsTV.separatorStyle = .singleLine
        flightDetailsTV.showsHorizontalScrollIndicator = false
        //flightDetailsTV.addBottomBorderWithColor(color: .AppBorderColor, width: 1)
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
    
    @IBAction func didTapOnViewFlightsDetailsBtn(_ sender: Any) {
        delegate?.didTapOnViewFlightsDetailsBtn(cell: self)
    }
    
    
}


extension FlightDetailsTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cellInfo?.key == "oneway" {
            return FlightList?[index].count ?? 0
        }else if cellInfo?.key == "circle"{
            return RTFlightList?[index].count ?? 0
        }else {
            return MCJflightlist?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        
        if cellInfo?.key == "oneway" {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchFlightResultTVCell {
                cell.selectionStyle = .none
               
                
                
                cell.holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 0)
                cell.hide()
                
                let data = FlightList?[index][indexPath.row].flight_details?.summary?[indexPath.row]
                cell.fromCityTimelbl.text = data?.origin?.time
                cell.fromCityShortlbl.text = data?.origin?.city
                cell.toCityTimelbl.text = data?.destination?.time
                cell.toCityShortlbl.text = data?.destination?.city
                cell.hourslbl.text = data?.duration
                cell.noStopslbl.text = "no of stops \(String(data?.no_of_stops ?? 0))"
                cell.airwaysLogoImg.sd_setImage(with: URL(string: data?.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.titlelbl.text = "\(data?.operator_name ?? "")(\(data?.operator_code ?? ""))"
                
                
                ccell = cell
            }
        }else if cellInfo?.key == "circle"{
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? SearchFlightResultTVCell {
                cell.selectionStyle = .none
                cell.deplbl.isHidden = true
                cell.airoplaneImg.isHidden = true
                
                let data = RTFlightList?[2][indexPath.row].flight_details?.summary?[indexPath.row]
                cell.holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 0)
                cell.hide()
                
                cell.fromCityTimelbl.text = data?.origin?.time
                cell.fromCityShortlbl.text = data?.origin?.city
                cell.toCityTimelbl.text = data?.destination?.time
                cell.toCityShortlbl.text = data?.destination?.city
                cell.hourslbl.text = data?.duration
                cell.noStopslbl.text = "no of stops \(String(data?.no_of_stops ?? 0))"
                cell.airwaysLogoImg.sd_setImage(with: URL(string: data?.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.titlelbl.text = "\(data?.operator_name ?? "")(\(data?.operator_code ?? ""))"
                
                ccell = cell
            }
            
        }else {
            
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? MCTripFlightTVCell {
                cell.selectionStyle = .none
                
                
//                let data = MCJflightlist?[index].flight_details?.summary?[indexPath.row]
////                airlinesNamelbl.text = data?.operator_name
////                airlineCodelbl.text = "(\(data?.operator_code ?? ""))"
////                datelbl.text = "22-10-22"
//
//                if indexPath.row == 0 {
//                    cell.kwdPricelbl.isHidden = false
//                    cell.kwdPricelbl.text = cellInfo?.title ?? "0"
//                    cell.perPersonlbl.text = "Per Person"
//                }else {
//                    cell.kwdPricelbl.isHidden = true
//                    cell.perPersonlbl.text = data?.origin?.date
//                }
//
//                cell.fromCityShortlbl.text = data?.origin?.loc
//                cell.fromCityTimelbl.text = data?.origin?.time
//                cell.toCityShortlbl.text = data?.destination?.loc
//                cell.toCityTimelbl.text = data?.destination?.time
//                cell.hourslbl.text = data?.duration
                
                ccell = cell
                
            }
        }
        
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultTVCell{
            delegate?.didTapOnFlightsDetails(cell: cell)
        }
        
    }
    
}
