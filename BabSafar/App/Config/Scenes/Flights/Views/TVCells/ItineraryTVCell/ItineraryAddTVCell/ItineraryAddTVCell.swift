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
            if data.origin?.terminal == "" {
                cell.terminal1lbl.text = "Terminal: 0"
            }else {
                cell.terminal1lbl.text = "Terminal: \(data.origin?.terminal ?? "0")"
            }
            
            cell.hourlbl1.text = data.duration
            cell.destTime.text = "\(data.destination?.time ?? "")"
            cell.destDate.text = "\(data.destination?.date ?? "")"
            cell.destlbl.text = "\(data.destination?.airport_name ?? "")"
            
            if data.destination?.terminal == "" {
                cell.destTerminal1lbl.text = "Terminal: 0"
            }else {
                cell.destTerminal1lbl.text = "Terminal: \(data.destination?.terminal ?? "0")"
            }
            
            cell.timelbl.text = "Layover Duration\(data.destination?.city ?? "") (\(data.destination?.loc ?? "")) \(data.layOverDuration ?? "")"
            
            if tableView.isLast(for: indexPath) {
                cell.timeView.isHidden = true
              
            }
            
            cell.airwaysImg1.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            c = cell
        }
        return c
    }
    
    
    
}
