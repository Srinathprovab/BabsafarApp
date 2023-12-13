//
//  AddTravellerTVCell.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData




protocol AddTravellerTVCellDelegate {
    
    
    func didTapOnAddAdultBtn(cell:AddTravellerTVCell)
    func didTapOnAddChildBtn(cell:AddTravellerTVCell)
    func didTapOnAddInfantaBtn(cell:AddTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddTravellerTVCell: TableViewCell,AddAdultsOrGuestTVCellDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var childlbl: UILabel!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addChildHolderView: UIView!
    @IBOutlet weak var addChildBtnView: UIView!
    @IBOutlet weak var addchildlbl: UILabel!
    @IBOutlet weak var addChildBtn: UIButton!
    @IBOutlet weak var addChildTV: UITableView!
    @IBOutlet weak var addChildTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addChildHolderViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var addInfantaHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var addInfantaBtnView: UIView!
    @IBOutlet weak var addInfantalbl: UILabel!
    @IBOutlet weak var addInfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantaTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addInfantaHolderViewHeight: NSLayoutConstraint!
    
    
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var delegate:AddTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var cdetails  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    var totalNoOfTravellers = String()
    var checkBool5 = true
    var passengerArray = [Passenger]()

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        setupChildTV()
        setupInfantaTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {

//        checkOptionCountArray.removeAll()
//        passengertypeArray.removeAll()
//        title2Array.removeAll()
//        fnameArray.removeAll()
//        lnameArray.removeAll()
//        dobArray.removeAll()
//        passportNoArray.removeAll()
//        countryCodeArray.removeAll()
//        passportexpiryArray.removeAll()
//        passportissuingcountryArray.removeAll()
//        middleNameArray.removeAll()
//        leadPassengerArray.removeAll()
//        genderArray.removeAll()

    }
    
    
    override func updateUI() {
        checkOptionCountArray.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Adult")
            fetchAdultCoreDataValues(str: "Children")
            fetchAdultCoreDataValues(str: "Infantas")
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }
        }
        
        
        if childCount == 0 {
            addChildHolderView.isHidden = true
            addChildTV.isHidden = true
            addChildTVHeight.constant = 0
            addChildHolderViewHeight.constant = 0
        }
        
        if infantsCount == 0 {
            addInfantaHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantaTVHeight.constant = 0
            addInfantaHolderViewHeight.constant = 0
        }
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
            
            if adultTravllersArray.count > 0 {
                let height = adultTravllersArray.count * 50
                adultTVHeight.constant = CGFloat(height)
            }
            
            
            if childTravllersArray.count > 0 && childCount > 0{
                let height = childTravllersArray.count * 50
                addChildTVHeight.constant = CGFloat(height)
            }
            
            
            if infantaTravllersArray.count > 0 && infantsCount > 0{
                let height = infantaTravllersArray.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
            
        }else {
            if cdetails.count == childCount {
                addChildBtnView.isHidden = true
            }
            
            if idetails.count == infantsCount {
                addInfantaBtnView.isHidden = true
            }
            
            
            
            if adetails.count > 0 {
                let height = adetails.count * 50
                adultTVHeight.constant = CGFloat(height)
            }
            
            
            if cdetails.count > 0 {
                let height = cdetails.count * 50
                addChildTVHeight.constant = CGFloat(height)
            }
            
            
            if idetails.count > 0 {
                let height = idetails.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
        }
        
        self.contentView.layoutIfNeeded()
        self.addAdultTV.reloadData()
        self.addChildTV.reloadData()
        self.addInfantaTV.reloadData()
        
        
        switch cellInfo?.key {
        case "hotel":
            travelImg.image = UIImage(named: "travel")
            titlelbl.text = cellInfo?.title
            totalNoOfTravellerlbl.text = cellInfo?.subTitle
        default:
            break
        }
        
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        addChildTVHeight.constant = 0
        infantaTVHeight.constant = 0
        
        contentView.backgroundColor = .AppHolderViewColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        addAdultHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        addChildHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        addInfantaHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        
        
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addChildHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addInfantaHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setupViews(v: addChildBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setupViews(v: addInfantaBtnView, radius: 15, color: HexColor("#FCEDFF"))
        
        
        travelImg.image = UIImage(named: "travel")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Traveller Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
        setuplabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: childlbl, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: addlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: addchildlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: addInfantalbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        
        setuplabels(lbl: totalNoOfTravellerlbl, text: "Total No Of  Tra :\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0")", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 12), align: .right)
        
        addAdultBtn.setTitle("", for: .normal)
        addChildBtn.setTitle("", for: .normal)
        addInfantaBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupAdultTV() {
        addAdultTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addAdultTV.delegate = self
        addAdultTV.dataSource = self
        addAdultTV.tableFooterView = UIView()
        addAdultTV.separatorStyle = .none
        addAdultTV.showsHorizontalScrollIndicator = false
        addAdultTV.isScrollEnabled = false
        addAdultTV.allowsMultipleSelection = true
    }
    
    func setupChildTV() {
        addChildTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        addChildTV.delegate = self
        addChildTV.dataSource = self
        addChildTV.tableFooterView = UIView()
        addChildTV.separatorStyle = .none
        addChildTV.showsHorizontalScrollIndicator = false
        addChildTV.isScrollEnabled = false
        addChildTV.allowsMultipleSelection = true
    }
    
    
    func setupInfantaTV() {
        addInfantaTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        addInfantaTV.delegate = self
        addInfantaTV.dataSource = self
        addInfantaTV.tableFooterView = UIView()
        addInfantaTV.separatorStyle = .none
        addInfantaTV.showsHorizontalScrollIndicator = false
        addInfantaTV.isScrollEnabled = false
        addInfantaTV.allowsMultipleSelection = true
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppHolderViewColor.cgColor
    }
    
    
    
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOnEditTraveller(cell: cell)
    }
    
    
    
    
    
    func didTapOnOptionBtn(cell:AddAdultsOrGuestTVCell){
        
        
        if checkBool5 == true {
            
            if (Int(totalNoOfTravellers) ?? 0) >= checkOptionCountArray.count {
                checkOptionCountArray.append(cell.travellerId)
            }
            
            cell.checkImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = false
        }else {
            if cell.indexPath?.row ?? 0 < checkOptionCountArray.count && !(cell.indexPath?.row ?? 0 < 0) {
                checkOptionCountArray.remove(at: cell.indexPath?.row ?? 0)
            }
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            checkBool5 = true
        }
        
        print(checkOptionCountArray)
    }
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddChildBtn(_ sender: Any) {
        delegate?.didTapOnAddChildBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            if str == "Adult" {
                adetails = try context.fetch(request)
            }else if str == "Children" {
                cdetails = try context.fetch(request)
            }else {
                idetails = try context.fetch(request)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    
}


extension AddTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            if tableView == addAdultTV {
                return adultTravllersArray.count
            }else if tableView == addChildTV{
                return childTravllersArray.count
            }else {
                return infantaTravllersArray.count
            }
        }else {
            if tableView == addAdultTV {
                return adetails.count
            }else if tableView == addChildTV{
                return cdetails.count
            }else {
                return idetails.count
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if tableView == addAdultTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                
                
                if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                    let data = adultTravllersArray[indexPath.row]
                    cell.titlelbl.text = data.first_name
                    cell.travellerId = data.origin ?? ""
                    cell.index = cell.indexPath?.row ?? 0
                    if   adultTravllersArray.count > adultsCount || adultTravllersArray.count == adultsCount{
                        addAdultBtnView.isHidden = true
                    }else {
                        addAdultBtnView.isHidden = false
                    }
                    
                    
                 //   cell.isSelected = tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false

//
//                    if arrayOf_SelectedCellsAdult.contains(indexPath) {
//                        if adultTravllersArray.count > 0 {
//                            addData(indexPath: indexPath, type1: "Adult")
//                        }
//                    }
                    
                    
                    
                }else {
                    let data = adetails as! [NSManagedObject]
                    cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                    cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                    if   adetails.count > adultsCount || adetails.count == adultsCount{
                        addAdultBtnView.isHidden = true
                    }else {
                        addAdultBtnView.isHidden = false
                    }
                    
//                    if arrayOf_SelectedCellsAdult.contains(indexPath) {
//                        if adetails.count > 0 {
//                            addData(indexPath: indexPath, type1: "Adult")
//                        }
//                    }
                    
                }
                
                
                ccell = cell
            }
            
        }else if tableView == addChildTV {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                cell.checkOptionBtn.tag = cell.indexPath?.row ?? 0
                if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                    let data = childTravllersArray[indexPath.row]
                    cell.titlelbl.text = data.first_name
                    cell.travellerId = data.origin ?? ""
                    cell.index = cell.indexPath?.row ?? 0
                    if   childTravllersArray.count > childCount || childTravllersArray.count == childCount{
                        addChildBtnView.isHidden = true
                    }else {
                        addChildBtnView.isHidden = false
                    }
                    
//                    if arrayOf_SelectedCellsChild.contains(indexPath) {
//
//                        if childTravllersArray.count > 0 {
//                            addData(indexPath: indexPath, type1: "Child")
//                        }
//                    }
                    
                    
                }else {
                    let data = cdetails as! [NSManagedObject]
                    cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                    cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                    if   cdetails.count > childCount || cdetails.count == childCount{
                        addChildBtnView.isHidden = true
                    }else {
                        addChildBtnView.isHidden = false
                    }
                    
//                    if arrayOf_SelectedCellsChild.contains(indexPath) {
//                        if cdetails.count > 0 {
//                            addData(indexPath: indexPath, type1: "Child")
//                        }
//                    }
                }
                
                
                ccell = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? AddAdultsOrGuestTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                cell.checkOptionBtn.tag = cell.indexPath?.row ?? 0
                if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                    let data = infantaTravllersArray[indexPath.row]
                    cell.titlelbl.text = data.first_name
                    cell.travellerId = data.origin ?? ""
                    cell.index = cell.indexPath?.row ?? 0
                    if   infantaTravllersArray.count > infantsCount || infantaTravllersArray.count == infantsCount{
                        addInfantaBtnView.isHidden = true
                    }else {
                        addInfantaBtnView.isHidden = false
                    }
                    

                }else {
                    let data = idetails as! [NSManagedObject]
                    cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
                    cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
                    if   idetails.count > infantsCount || idetails.count == infantsCount{
                        addInfantaBtnView.isHidden = true
                    }else {
                        addInfantaBtnView.isHidden = false
                    }
                    

                }
                
                
                ccell = cell
            }
        }
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
