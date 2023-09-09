//
//  NewRoomTVCell.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import UIKit





protocol NewRoomTVCellDelegate {
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
}

class NewRoomTVCell: TableViewCell, NewRoomDetailsTVCellDelegate {
    
    
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    @IBOutlet weak var roomInfoTV: UITableView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var topView: BorderedView!
    
     var newRoomindexPath: IndexPath?
    var room = [Rooms]()
    var delegate:NewRoomTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setuTV() {
        roomInfoTV.register(UINib(nibName: "NewRoomDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roomInfoTV.delegate = self
        roomInfoTV.dataSource = self
        roomInfoTV.tableFooterView = UIView()
        roomInfoTV.separatorStyle = .none
        roomInfoTV.showsHorizontalScrollIndicator = false
        
        roomInfoTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        roomInfoTV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
        roomInfoTV.layer.cornerRadius = 10
        roomInfoTV.clipsToBounds = true
        roomInfoTV.isScrollEnabled = false
        
        topView.layer.borderColor = UIColor.AppBorderColor.cgColor
        topView.layer.borderWidth = 1
        
        topView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
    }
    
    
    func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: cell)
    }
    
    func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnSelectRoomBtnAction(cell: cell)
    }
    
    
    
    
}


extension NewRoomTVCell: UITableViewDataSource ,UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return room.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewRoomDetailsTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            let data = room[indexPath.row]
            self.titlelbl.text = data.name ?? ""
            cell.pricelbl.text = "\(data.currency ?? ""):\(data.net ?? "")"
            cell.indexpathvalue = newRoomindexPath
            
            if data.refund == true {
                cell.fareTypelbl.text = "Refundable"
                cell.fareTypeString = "Refundable"
            }else {
                cell.fareTypelbl.text = "Non Refundable"
                cell.fareTypeString = "Non Refundable"
            }
            
            // Access the cancellationPolicies array
            if let cancellationPolicies1 = data.cancellationPolicies {
                // Iterate over the cancellationPolicies array
                for policy in cancellationPolicies1 {
                    let amount = policy.amount
                    let fromDate = policy.from
                    cell.CancellationPolicyAmount = amount ?? ""
                    cell.CancellationPolicyFromDate = fromDate ?? ""
                    
                }
            }
            
            
            
            // Set the initial background color of the selectRoomBtnView
            //  cell.selectRoomBtnView.backgroundColor = cell.isSelectedCell ? .AppCalenderDateSelectColor : .AppBtnColor
            
            // Check if the current cell's index is in the selectedCellIndices array
            if selectedCellIndices.contains(indexPath) {
                cell.isSelectedCell = true
            } else {
                cell.isSelectedCell = false
            }
            
            
            
            cell.ratekey = data.rateKey ?? ""
            ccell = cell
        }
        
        return ccell
    }
    
    
    
}
