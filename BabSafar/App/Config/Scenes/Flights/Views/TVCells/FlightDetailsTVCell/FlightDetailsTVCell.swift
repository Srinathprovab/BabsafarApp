//
//  FlightDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 04/08/22.
//

import UIKit
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
    
        
        key = cellInfo?.key ?? ""
        if key == "roundtrip" {
            titlelbl.text = ""
            viewFlightsDetailsBtnView.isHidden = true
            flightDetailsTVHeight.constant = 10 * 75
            flightImgHeight.constant = 0
            flightImg.isHidden = true
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchFlightResultTVCell {
            cell.selectionStyle = .none
            cell.imagesHolderView.isHidden = true
            cell.imagesHolderHeight.constant = 0
            cell.holderView.layer.borderColor = UIColor.WhiteColor.cgColor
            cell.kwdPricelbl.text = ""
            cell.perPersonlbl.text = ""
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
