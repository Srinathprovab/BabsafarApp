//
//  FasttrackFlightDeatilsTVCell.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import UIKit


protocol FasttrackFlightDeatilsTVCellDelegate {
    func didTapOnCloseBtnAction(cell:SelectedServicesTVCell)
}

class FasttrackFlightDeatilsTVCell: TableViewCell {
    
    
    @IBOutlet weak var fasttrackDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var delegate:FasttrackFlightDeatilsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(quickServiceA.count * 255)
        fasttrackDetailsTV.reloadData()
    }
    
    override func updateUI() {
        updateHeight()
    }
    
    func setupUI(){
        setupTV()
    }
    
    
    @objc func  didTapOnCloseBtnAction() {
        
    }
    
}


extension FasttrackFlightDeatilsTVCell : UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        let nib = UINib(nibName: "SelectedServicesTVCell", bundle: nil)
        fasttrackDetailsTV.register(nib, forCellReuseIdentifier: "cell")
        fasttrackDetailsTV.delegate = self
        fasttrackDetailsTV.dataSource = self
        fasttrackDetailsTV.tableFooterView = UIView()
        fasttrackDetailsTV.separatorStyle = .none
        fasttrackDetailsTV.isScrollEnabled = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quickServiceA.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SelectedServicesTVCell {
            cell.selectionStyle = .none
            cell.index = indexPath.row
            let data = quickServiceA[indexPath.row]
            cell.logoImg.image = UIImage(named: data.logoimg)?.withRenderingMode(.alwaysOriginal)
            cell.fromAirportNamelbl.text = data.airportname
            cell.terminallbl.text = data.title
            cell.priceView.isHidden = false
            cell.pricelbl.text = data.price
            cell.cancelView.isHidden = true
            cell.closeView.isHidden = false
            cell.tapedservicetype = data.serviceType
            
           
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
