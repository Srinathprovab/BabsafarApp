//
//  TravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import CoreData

class BookingDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    static var newInstance: BookingDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreDataValues()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addAdultsDetails(notification:)), name: NSNotification.Name("addAdultsDetails"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func addAdultsDetails(notification:NSNotification) {
        setupTV()
    }
    
    @objc func reload(notification:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    
    func setupUI() {
       
        navBar.titlelbl.text = "Booking Details"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
       
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TDetailsLoginTVCell","EmptyTVCell","ContactInformationTVCell","TravelInsuranceTVCell","PriceSummaryTVCell","AddTravellerTVCell","FlightDetailsTVCell","SearchFlightResultTVCell"])
        
    }
    
    
    func setupTV() {
        
        tablerow.removeAll()
        
        if defaults.bool(forKey: UserDefaultsKeys.userLoggedIn) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        if let selectedJType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJType == "oneway" {
                tablerow.append(TableRow(key:"oneway",cellType:.FlightDetailsTVCell))
            }else if selectedJType == "circle" {
                tablerow.append(TableRow(key:"circle",cellType:.FlightDetailsTVCell))
            }else {
                tablerow.append(TableRow(key:"multicity",cellType:.FlightDetailsTVCell))
            }
            
        }
        
        tablerow.append(TableRow(cellType:.AddTravellerTVCell))
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.TravelInsuranceTVCell))
        tablerow.append(TableRow(cellType:.PriceSummaryTVCell))
        tablerow.append(TableRow(height:50, bgColor:.AppBorderColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnLoginBtn(cell:TDetailsLoginTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
    }
    
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        print("didTapOnCountryCodeBtn")
    }
    
    override func editingTextField(tf:UITextField){
        print(tf.tag)
    }
    
    override func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {
        print("didTapOnInsureSkipButton")
    }
    
    override func didTapOnPABtn(cell: TravelInsuranceTVCell) {
        print("didTapOnPABtn")
    }
    
    override func didTapOnTCBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTCBtn")
    }
    
    override func didTapOnTDBtn(cell: TravelInsuranceTVCell) {
        print("didTapOnTDBtn")
    }
    
    override func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTC1Btn")
    }
    
    override func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {
        print("didTapOnTD1Btn")
    }
    
    var showMoreBool = true
    override func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {
        if showMoreBool == true {
            cell.showMorelbl.text = "- Show Less"
            cell.optionView.isHidden = false
            cell.optionViewHeight.constant = 100
            showMoreBool = false
        }else {
            cell.showMorelbl.text = "+ Show More"
            cell.optionView.isHidden = true
            cell.optionViewHeight.constant = 0
            showMoreBool = true
        }
        
    }
    
    
    override func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioSelected")
        cell.radioImg2.image = UIImage(named: "radioUnselected")
    }
    
    override func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {
        cell.radioImg1.image = UIImage(named: "radioUnselected")
        cell.radioImg2.image = UIImage(named: "radioSelected")
    }
    
    override func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRemoveTravelInsuranceBtn")
    }
 
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func gotoAddTravellerOrGuestVC(str:String) {
        defaults.set(str, forKey: UserDefaultsKeys.travellerTitle)
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnAddAdultBtn(cell: AddTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Adult")
    }
    
    override func didTapOnAddChildBtn(cell: AddTravellerTVCell) {
        gotoAddTravellerOrGuestVC(str: "Children")
    }
    
    override func didTapOnEditAdultBtn(cell:AddTravellerTVCell){
       // gotoAddTravellerOrGuestVC(str: "edit")
    }
    
    override func didTapOnEditChildtBtn(cell:AddTravellerTVCell){
      //  gotoAddTravellerOrGuestVC(str: "edit")
    }
    
    override func didTapOnViewFlightsDetailsBtn(cell: FlightDetailsTVCell) {
//        cell.flightDetailsTVHeight.constant = 10 * 75
//        commonTableView.reloadData()
        dismiss(animated: true)
    }

    
    override func didTapOnFlightsDetails(cell:SearchFlightResultTVCell){
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.isVCFrom = "BookingDetailsVC"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    

    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        fnameArray.removeAll()
        mnameArray.removeAll()
        lnameArray.removeAll()
        dobArray.removeAll()
        passportNoArray.removeAll()
        countryCodeArray.removeAll()
        passportexpiryYearArray.removeAll()
        passportexpiryMonthArray.removeAll()
        passportexpirydayArray.removeAll()
        passportissuingcountryArray.removeAll()
        
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            print(result)
            for data in result as! [NSManagedObject]{
                print("fname ====== >\((data.value(forKey: "fname") as? String) ?? "")")
               
                
                fnameArray.append(data.value(forKey: "fname") as! String)
                lnameArray.append(data.value(forKey: "lname") as! String)
                dobArray.append(data.value(forKey: "dob") as! String)
                passportNoArray.append(data.value(forKey: "passportno") as! String)
               // countryCodeArray.append(data.value(forKey: "countryCode") as! String)
                passportissuingcountryArray.append(data.value(forKey: "passportissuingcountry") as! String)
                passportnationalityArray.append(data.value(forKey: "nationality") as! String)
                
                let dateString = "\(data.value(forKey: "passportexpirydate") as! String)"
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                guard let date = formatter.date(from: dateString) else {
                    return
                }
                
                formatter.dateFormat = "yyyy"
                let year = formatter.string(from: date)
                passportexpiryYearArray.append(year)
                formatter.dateFormat = "MM"
                let month = formatter.string(from: date)
                passportexpiryMonthArray.append(month)
                formatter.dateFormat = "dd"
                let day = formatter.string(from: date)
                passportexpirydayArray.append(day)
                print(year, month, day) // 2018 12 24
                
            }
            
            details = result
            
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteRecords(index:Int,id:String) {
        
        print("DELETING COREDATA OBJECT")
        print(index)
        print(id)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "id = %@", "\(id)")
        request.returnsObjectsAsFaults = false
        
        
        if details.count > 0 {
            
            
            do {
                let objects = try context.fetch(request)
                for object in details {
                    context.delete(object as! NSManagedObject)
                }
            } catch {
                print ("There was an error")
            }
        }
        
        
        do {
            try context.save()
        } catch {
            print ("There was an error")
        }
        
        
        DispatchQueue.main.async {[self] in
            
            fetchCoreDataValues()
            commonTableView.reloadData()
        }
    }
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteAllRecords() {
        
        if details.count > 0 {
            for object in details as! [NSManagedObject] {
                context.delete(object )
            }
        }
        
        
        do {
            try context.save()
        } catch {
            print ("There was an error")
        }
        
    }
    
    
    
    
    
}


extension BookingDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        myFooter.kwdlbl.text = totalprice
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
