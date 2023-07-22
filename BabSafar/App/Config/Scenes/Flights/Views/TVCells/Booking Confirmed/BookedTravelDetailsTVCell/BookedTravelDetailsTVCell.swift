//
//  BookedTravelDetailsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookedTravelDetailsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var labelsView: UIView!
    @IBOutlet weak var travellerNamelbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var seatlbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var adultDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var Customerdetails = [Customer_details]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func updateUI() {
        Customerdetails = cellInfo?.moreData as? [Customer_details] ?? []
        
        if Customerdetails.count > 0 {
            tvHeight.constant = CGFloat(Customerdetails.count * 35)
        }
        
        
        if cellInfo?.key == "hotel" {
            travellerNamelbl.text = "Guest Name"
            typelbl.text = "Type"
            seatlbl.text = "Room Type"
        }
        
        adultDetailsTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        holderView.layer.borderWidth = 1
        setupViews(v: labelsView, radius: 0, color: .WhiteColor)
        labelsView.layer.borderColor = UIColor.WhiteColor.cgColor
        // labelsView.addBottomBorderWithColor(color: .SubTitleColor, width: 1)
        ulView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: travellerNamelbl, text: "Traveller Name", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 13), align: .center)
        setuplabels(lbl: typelbl, text: "Ticket No", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 13), align: .center)
        setuplabels(lbl: seatlbl, text: "Status", textcolor: HexColor("#5B5B5B"), font: .LatoRegular(size: 13), align: .center)
        
    }
    
    func setupTV() {
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultDetailsTV.delegate = self
        adultDetailsTV.dataSource = self
        adultDetailsTV.tableFooterView = UIView()
        adultDetailsTV.showsHorizontalScrollIndicator = false
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
}


extension BookedTravelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Customerdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedAdultDetailsTVCell {
            cell.selectionStyle = .none
            
            let data = Customerdetails[indexPath.row]
            cell.travellerNamelbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
            cell.typelbl.text = data.ticket_no ?? ""
            cell.seatlbl.text = data.status ?? ""
            
            
            c = cell
        }
        return c
    }
    
    
    
}
