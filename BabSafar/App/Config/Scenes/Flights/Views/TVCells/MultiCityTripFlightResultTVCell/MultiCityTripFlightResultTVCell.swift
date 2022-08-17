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
    @IBOutlet weak var multiCityTripTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:MultiCityTripFlightResultTVCellDelegate?
    var arrayCount = Int()
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
        arrayCount = cellInfo?.characterLimit ?? 2
        tvHeight.constant = CGFloat((arrayCount * 161) - 100)
    }
    
    func setupUI() {
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        setupTV()
    }
    
    func setupTV() {
        multiCityTripTV.register(UINib(nibName: "SearchFlightResultTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        multiCityTripTV.delegate = self
        multiCityTripTV.dataSource = self
        multiCityTripTV.tableFooterView = UIView()
        multiCityTripTV.showsHorizontalScrollIndicator = false
        multiCityTripTV.layer.cornerRadius = 10
        multiCityTripTV.clipsToBounds = true
        multiCityTripTV.layer.borderWidth = 1
        multiCityTripTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchFlightResultTVCell {
            cell.selectionStyle = .none
            cell.imagesHolderView.isHidden = true
            cell.imagesHolderHeight.constant = 0
            cell.holderView.layer.borderColor = UIColor.WhiteColor.cgColor
            
            
            if indexPath.row == 0 {
                cell.kwdPricelbl.text = "KWD:150.00"
                cell.perPersonlbl.text = "Per Person"
            }else {
                cell.kwdPricelbl.text = ""
                cell.perPersonlbl.text = "Web 28 Jul"
            }
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoRoundTripBaggageIntoVC()
    }
    
}
