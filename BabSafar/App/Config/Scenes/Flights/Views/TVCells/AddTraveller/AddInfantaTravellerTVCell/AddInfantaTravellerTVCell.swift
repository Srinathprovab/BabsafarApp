//
//  AddInfantaTravellerTVCell.swift
//  BabSafar
//
//  Created by FCI on 08/03/23.
//

import UIKit




import UIKit
import CoreData


protocol AddInfantaTravellerTVCellDelegate {
    
    
    func didTapOnAddInfantaBtn(cell:AddInfantaTravellerTVCell)
    func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell)
    func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell)
    func didTapOnSelectAdultTraveller(Cell:AddAdultsOrGuestTVCell)
    
}


class AddInfantaTravellerTVCell: TableViewCell,AddAdultsOrGuestTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addInfantaHolderView: UIView!
    @IBOutlet weak var infantalbl: UILabel!
    @IBOutlet weak var addInfantaBtnView: UIView!
    @IBOutlet weak var addInfantalbl: UILabel!
    @IBOutlet weak var addInfantaBtn: UIButton!
    @IBOutlet weak var addInfantaTV: UITableView!
    @IBOutlet weak var infantaTVHeight: NSLayoutConstraint!
    
    
    var infantsCount = 0
    var delegate:AddInfantaTravellerTVCellDelegate?
    var details  = [NSFetchRequestResult]()
    var idetails  = [NSFetchRequestResult]()
    var checkBool5 = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupInfantaTV()
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
            fetchAdultCoreDataValues(str: "Infantas")
        }else {
            details = (cellInfo?.moreData as? [NSFetchRequestResult] ?? [])
            fetchAdultCoreDataValues(str: "Infantas")
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
            }else if journeyType == "circle"{
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            }else {
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
        }
        
        
        
        
        if infantsCount == 0 {
            addInfantaHolderView.isHidden = true
            addInfantaTV.isHidden = true
            infantaTVHeight.constant = 0
        }
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            
//            if infantaTravllersArray.count > 0 && infantsCount > 0{
//                let height = infantaTravllersArray.count * 50
//                infantaTVHeight.constant = CGFloat(height)
//            }
            
            
            if idetails.count == infantsCount {
                addInfantaBtnView.isHidden = true
            }
            
            
            if idetails.count > 0 {
                let height = idetails.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
        }else {
            
            
            if idetails.count == infantsCount {
                addInfantaBtnView.isHidden = true
            }
            
            
            if idetails.count > 0 {
                let height = idetails.count * 50
                infantaTVHeight.constant = CGFloat(height)
            }
            
        }
        
        self.contentView.layoutIfNeeded()
        self.addInfantaTV.reloadData()
        
        
        
    }
    
    func setupUI() {
        
        infantaTVHeight.constant = 0
        
        contentView.backgroundColor = .AppHolderViewColor
        addInfantaHolderView.addBottomBorderWithColor(color: .AppHolderViewColor, width: 1)
        setupViews(v: addInfantaHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: addInfantaBtnView, radius: 15, color: HexColor("#FCEDFF"))
        setuplabels(lbl: infantalbl, text: "Infanta", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: addInfantalbl, text: "+ Add", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        addInfantaBtn.setTitle("", for: .normal)
        
        
    }
    
    
    func setupInfantaTV() {
        addInfantaTV.register(UINib(nibName: "AddAdultsOrGuestTVCell", bundle: nil), forCellReuseIdentifier: "cell")
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
    
    
    
    @IBAction func didTapOnAddInfantaBtn(_ sender: Any) {
        delegate?.didTapOnAddInfantaBtn(cell: self)
    }
    
    
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {
        deleteRecords(index: cell.deleteBtn.tag, id: cell.travellerId, type: "Infantas")
        if   idetails.count > infantsCount || idetails.count == infantsCount{
            addInfantaBtnView.isHidden = true
        }else {
            addInfantaBtnView.isHidden = false
        }
        delegate?.didTapOndeleteTravellerBtnAction(cell: cell)
    }
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchAdultCoreDataValues(str:String) {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        
        request.predicate = NSPredicate(format: "title = %@", "\(str)")
        request.returnsObjectsAsFaults = false
        do {
            
            idetails = try context.fetch(request)
            
            
        } catch {
            
            print("Failed")
        }
    }
    
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String,type:String) {
        if idetails.count > 0 {
            context.delete(idetails[index] as! NSManagedObject )
            idetails.remove(at: index)
            
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
            
            
            self.addInfantaTV.deleteRows(at: [IndexPath(item: index, section: 0)], with: .fade)
            updateUI()
            
        }
    }
    
    
    
}


extension AddInfantaTravellerTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddAdultsOrGuestTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.checkOptionBtn.tag = cell.indexPath?.row ?? 0
            let data = idetails as! [NSManagedObject]
            cell.titlelbl.text = data[indexPath.row].value(forKey: "fname") as? String
            cell.travellerId = data[indexPath.row].value(forKey: "id") as? String ?? ""
            cell.passengerType = "Infant"
            
            if   idetails.count > infantsCount || idetails.count == infantsCount{
                addInfantaBtnView.isHidden = true
            }else {
                addInfantaBtnView.isHidden = false
            }
            
            ccell = cell
        }
        
        
        return ccell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
  
    
}
