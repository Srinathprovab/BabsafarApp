//
//  VocherRoundTripFlightDetailsTVCell.swift
//  BabSafar
//
//  Created by FCI on 23/02/23.
//

import UIKit

class VocherRoundTripFlightDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fdetailsTV: UITableView!
    @IBOutlet weak var fdetailsTVHeight: NSLayoutConstraint!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var perPersonlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        kwdlbl.text = cellInfo?.title ?? ""
      //  fdetails = cellInfo?.moreData
        fdetailsTVHeight.constant = CGFloat(3 * 136)
        fdetailsTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 8)
        setuplabels(lbl: kwdlbl, text: "", textcolor: HexColor("#64276F"), font: .LatoRegular(size: 16), align: .center)
        setuplabels(lbl: perPersonlbl, text: "Per Person", textcolor: .AppLabelColor, font: .LatoRegular(size: 13), align: .center)

        setupTV()
    }
    
    
    func setupTV() {
        fdetailsTV.register(UINib(nibName: "SearchFlightResultTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        fdetailsTV.delegate = self
        fdetailsTV.dataSource = self
        fdetailsTV.tableFooterView = UIView()
        fdetailsTV.showsHorizontalScrollIndicator = false
        fdetailsTV.separatorStyle = .none
        fdetailsTV.isScrollEnabled = false
    }
    
    
    
    
    
}


extension VocherRoundTripFlightDetailsTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VocherFlightDetailsTVCell {
            cell.selectionStyle = .none
            cell.kwdlbl.isHidden = true
            
            
            ccell = cell
        }
        return ccell
    }

}
