//
//  RoomsTVcell.swift
//  BabSafar
//
//  Created by MA673 on 01/08/22.
//

import UIKit

protocol RoomsTVcellDelegate {
    func didTapOnRoomsBtn(cell:RoomsTVcell)
    func didTapOnHotelsDetailsBtn(cell:RoomsTVcell)
    func didTapOnAmenitiesBtn(cell:RoomsTVcell)
    func didTapOnCancellationPolicyBtnAction(cell:NewRoomDetailsTVCell)
    func didTapOnSelectRoomBtnAction(cell:NewRoomDetailsTVCell)
}

class RoomsTVcell: TableViewCell, NewRoomTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roomsView: UIView!
    @IBOutlet weak var roomslbl: UILabel!
    @IBOutlet weak var roomsUL: UIView!
    @IBOutlet weak var roomsBtn: UIButton!
    @IBOutlet weak var hotelsDetailsView: UIView!
    @IBOutlet weak var hotelsDetailslbl: UILabel!
    @IBOutlet weak var hotelsDetailsUL: UIView!
    @IBOutlet weak var hotelsDetailsBtn: UIButton!
    @IBOutlet weak var amenitiesView: UIView!
    @IBOutlet weak var amenitieslbl: UILabel!
    @IBOutlet weak var amenitiesUL: UIView!
    @IBOutlet weak var amenitiesBtn: UIButton!
    @IBOutlet weak var roomDetailsTV: UITableView!
    
    
    
    var selectedCell: NewRoomDetailsTVCell?
    var delegate:RoomsTVcellDelegate?
    var key = "rooms"
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
        roomDetailsTV.reloadData()
    }
    
    
    func setupUI() {
        
        setupViews(v: holderView, radius: 0, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: roomsView, radius: 0, color: .WhiteColor)
        roomsView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: hotelsDetailsView, radius: 0, color: .WhiteColor)
        hotelsDetailsView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: amenitiesView, radius: 0, color: .WhiteColor)
        amenitiesView.layer.borderColor = UIColor.WhiteColor.cgColor
        roomsUL.backgroundColor = .AppTabSelectColor
        hotelsDetailsUL.backgroundColor = .WhiteColor
        amenitiesUL.backgroundColor = .WhiteColor
        
        setuplabels(lbl: roomslbl, text: "Rooms", textcolor: .AppTabSelectColor, font: .LatoBold(size: 16), align: .center)
        setuplabels(lbl: hotelsDetailslbl, text: "Hotels Details", textcolor: .AppLabelColor.withAlphaComponent(0.5), font: .LatoBold(size: 16), align: .center)
        setuplabels(lbl: amenitieslbl, text: "Amenities", textcolor: .AppLabelColor.withAlphaComponent(0.5), font: .LatoBold(size: 16), align: .center)
        
        roomsBtn.setTitle("", for: .normal)
        hotelsDetailsBtn.setTitle("", for: .normal)
        amenitiesBtn.setTitle("", for: .normal)
        
        setuTV()
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }
    
    
    func setuTV() {
        roomDetailsTV.register(UINib(nibName: "NewRoomTVCell", bundle: nil), forCellReuseIdentifier: "rooms")
        roomDetailsTV.register(UINib(nibName: "TitleLabelTVCell", bundle: nil), forCellReuseIdentifier: "hdetails")
//        roomDetailsTV.register(UINib(nibName: "TitleLabelTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
//        roomDetailsTV.register(UINib(nibName: "TitleLabelTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        roomDetailsTV.register(UINib(nibName: "AmenitiesTVCell", bundle: nil), forCellReuseIdentifier: "amenities")
        
        
        
        roomDetailsTV.delegate = self
        roomDetailsTV.dataSource = self
        roomDetailsTV.tableFooterView = UIView()
        roomDetailsTV.separatorStyle = .none
        roomDetailsTV.showsHorizontalScrollIndicator = false
    }
    
    
    
    @IBAction func didTapOnRoomsBtn(_ sender: Any) {
        roomslbl.textColor = .AppTabSelectColor
        roomsUL.backgroundColor = .AppTabSelectColor
        hotelsDetailslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        hotelsDetailsUL.backgroundColor = .WhiteColor
        amenitieslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        amenitiesUL.backgroundColor = .WhiteColor
        
        delegate?.didTapOnRoomsBtn(cell:self)
    }
    
    
    @IBAction func didTapOnHotelsDetailsBtn(_ sender: Any) {
        hotelsDetailslbl.textColor = .AppTabSelectColor
        hotelsDetailsUL.backgroundColor = .AppTabSelectColor
        roomslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        roomsUL.backgroundColor = .WhiteColor
        amenitieslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        amenitiesUL.backgroundColor = .WhiteColor
        
        
        print(formatDesc.count)
        
        delegate?.didTapOnHotelsDetailsBtn(cell:self)
    }
    
    
    @IBAction func didTapOnAmenitiesBtn(_ sender: Any) {
        amenitieslbl.textColor = .AppTabSelectColor
        amenitiesUL.backgroundColor = .AppTabSelectColor
        roomslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        roomsUL.backgroundColor = .WhiteColor
        hotelsDetailslbl.textColor = .AppLabelColor.withAlphaComponent(0.5)
        hotelsDetailsUL.backgroundColor = .WhiteColor
        
        delegate?.didTapOnAmenitiesBtn(cell:self)
    }
    
    
    
    func didTapOnCancellationPolicyBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnCancellationPolicyBtnAction(cell: cell)
    }
    
    func didTapOnSelectRoomBtnAction(cell: NewRoomDetailsTVCell) {
        delegate?.didTapOnSelectRoomBtnAction(cell: cell)
    }
    
    
}


extension RoomsTVcell: UITableViewDataSource ,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.key == "rooms" {
            return roomsDetails.count
        }
//        else if self.key == "hotels details"{
//            return formatDesc.count
//        }
        else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.key == "rooms" {
            return roomsDetails[section].count
        }
        else if self.key == "hotels details"{
            return formatDesc.count
        }
        else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if self.key == "rooms" {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "rooms") as? NewRoomTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                if indexPath.section < roomsDetails.count && indexPath.row < roomsDetails[indexPath.section].count {
                    
                    //  cell.newRoomindexPath = IndexPath(row: indexPath.row, section: indexPath.section)
                    
                    let section = indexPath.section
                    let data = roomsDetails[section]
                    cell.room = data
                    cell.tvheight.constant = CGFloat(cell.room.count * 101)
                    cell.roomInfoTV.reloadData()
                    
                } else {
                    print("Index out of range error: indexPath = \(indexPath)")
                }
                
                
                ccell = cell
            }
        }else if self.key == "hotels details"{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "hdetails") as? TitleLabelTVCell {
                cell.selectionStyle = .none
                cell.hotelNamelbl.attributedText = "\(formatDesc[indexPath.row].heading ?? "")".htmlToAttributedString
                cell.locationlbl.attributedText = formatDesc[indexPath.row].content?.htmlToAttributedString
                cell.setupHotelDetails()
                ccell = cell
            }
            
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "amenities") as? AmenitiesTVCell {
                cell.selectionStyle = .none
                if formatAmeArray.count == 0 {
                    cell.amenitiesCV.setEmptyMessage("No Data Found")
                }else {
                    cell.amenitiesCV.reloadData()
                }
                
                ccell = cell
            }
        }
        return ccell
    }
    
  
    
}
