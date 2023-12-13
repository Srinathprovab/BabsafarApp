//
//  AddAdultTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit
import CoreData

struct Passenger {
    var passengerType: String
    var title2Code: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var passportExpiryDate: String
    var passportNumber: String
    var countryCode: String
    var passportIssuingCountry: String
    var middleName: String
    var isLeadPassenger: String
    var gender: String
}

protocol AddAdultTravellerTVCellDelegate {
    
    
    func didTapOnAddAdultBtn(cell:AddAdultTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddAdultTravellerTVCell: TableViewCell, AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleHolderView: UIView!
    @IBOutlet weak var travelImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var totalNoOfTravellerlbl: UILabel!
    @IBOutlet weak var addAdultHolderView: UIView!
    @IBOutlet weak var addAdultBtnView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addAdultTV: UITableView!
    @IBOutlet weak var adultTVHeight: NSLayoutConstraint!
    
    
    var adultsCount = 1
    var delegate:AddAdultTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var adetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    var checkOptionCountArray1 = [String]()
    var passengertypeArray1 = [String]()
    var title2Array1 = [String]()
    var fnameArray1 = [String]()
    var lnameArray1 = [String]()
    var dobArray1 = [String]()
    var passportNoArray1 = [String]()
    var countryCodeArray1 = [String]()
    var passportexpiryArray1 = [String]()
    var passportissuingcountryArray1 = [String]()
    var middleNameArray1 = [String]()
    var leadPassengerArray1 = [String]()
    var genderArray1 = [String]()
    var arrayOf_SelectedCellsAdult1 = [IndexPath]()
    
    
    // Create an instance of NSCache
    let cache = NSCache<NSString, AnyObject>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupAdultTV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        
    }
    
    
    override func updateUI() {
        checkOptionCountArray.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Adult")
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Adult")
            
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
            }
        }
        
        
        
        if adetails.count > 0 {
            let height = adetails.count * 50
            adultTVHeight.constant = CGFloat(height)
        }
        
        
        self.addAdultTV.reloadData()
        
        
    }
    
    func setupUI() {
        adultTVHeight.constant = 0
        
        contentView.backgroundColor = .AppHolderViewColor
        setupViews(v: holderView, radius: 4, color: .WhiteColor)
        holderView.layer.borderColor = UIColor.WhiteColor.cgColor
        setupViews(v: titleHolderView, radius: 0, color: .WhiteColor)
        titleHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        addAdultHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        
        setupViews(v: addAdultHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addAdultBtnView, radius: 15, color: HexColor("#FCEDFF"))
        
        travelImg.image = UIImage(named: "travel")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: addlbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected)
        if tabselect == "Flights"{
            setuplabels(lbl: titlelbl, text: "Traveller Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
            setuplabels(lbl: totalNoOfTravellerlbl, text: "Total No Of  Tra :\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0")", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 12), align: .right)
        }else {
            setuplabels(lbl: titlelbl, text: "Guest Details", textcolor: .AppLabelColor, font: .LatoSemibold(size: 16), align: .left)
            setuplabels(lbl: totalNoOfTravellerlbl, text: "Total No Of  Tra :\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "0")", textcolor: .AppCalenderDateSelectColor, font: .LatoRegular(size: 12), align: .right)
            totalNoOfTravellerlbl.isHidden = true
        }
        
        
        
        
        
        addAdultBtn.setTitle("", for: .normal)
        
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
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Adult")
        if   adetails.count > adultsCount || adetails.count == adultsCount{
            addAdultBtnView.isHidden = true
        }else {
            addAdultBtnView.isHidden = false
        }
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            adetails = try context.fetch(request)
            if let myEntity = adetails.first {
                
                // Set the CoreData object in the cache with a key
                cache.setObject(myEntity as AnyObject, forKey: "myEntityCacheKey")
            }
            
        }catch let error as NSError {
            print("Error fetching object from CoreData: \(error.localizedDescription)")
        }
    }
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        
        if adetails.count > 0 {
            context.delete(adetails[index] as! NSManagedObject )
            adetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            
            
            self.addAdultTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
}


extension AddAdultTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adetails.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            cell.passengerType = "Adult"
            cell.deleteBtn.tag = indexPath.row
            
            // Retrieve the NSManagedObject for the current row
            guard let data = adetails[indexPath.row] as? NSManagedObject else {
                return cell
            }
            
            cell.titlelbl.text = data.value(forKey: "fname") as? String ?? ""
            cell.travellerId = data.value(forKey: "id") as? String ?? ""
            cell.index = cell.indexPath?.row ?? 0
            
            if   adetails.count > adultsCount || adetails.count == adultsCount{
                addAdultBtnView.isHidden = true
            }else {
                addAdultBtnView.isHidden = false
            }
            
            
            ccell = cell
        }
        
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

