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
        tvHeight.constant = CGFloat(arrayCount * 161)
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
    }
    
    func gotoRoundTripBaggageIntoVC() {
        delegate?.gotoRoundTripBaggageIntoVC(cell: self)
    }
}


extension RoundTripFlightResultTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchFlightResultTVCell {
            cell.selectionStyle = .none
            cell.holderViewTopConstraint.constant = 0
            cell.holderView.layer.cornerRadius = 0
            cell.holderView.clipsToBounds = true
            cell.holderView.layer.borderColor = UIColor.clear.cgColor
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoRoundTripBaggageIntoVC()
    }
    
}
