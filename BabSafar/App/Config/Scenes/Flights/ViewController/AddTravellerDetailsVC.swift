//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData

class AddTravellerDetailsVC: BaseTableVC, ShowTravellerDetailsViewModelDelegate, UpdateTravellerDetailsVMDelegate {
    
    
    @IBOutlet weak var navBar: NavBar!
    // @IBOutlet weak var navheight: NSLayoutConstraint!
    
    //MARK: - variables Decleration
    
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    
    var fname:String?
    var lname = String()
    var documentType = String()
    var passportno = String()
    var passportExpiryDate = String()
    var gender = "Male"
    var ptitle = String()
    var issuedCountry = String()
    var experiesOn = String()
    var dob = String()
    var rno = Int()
    var issuingCountry = String()
    var issuingCountrycode = String()
    var issuingCountryName = String()
    var mobileno = String()
    var email = String()
    var textFieldText = ""
    var key = String()
    var id = String()
    var title1 = String()
    var title2 = String()
    var title2Code = String()
    var tablerow = [TableRow]()
    var passengerType = String()
    var payload = [String:Any]()
    var vm :ShowTravellerDetailsViewModel?
    var updateDetailsvm:UpdateTravellerDetailsVM?
    var origin = String()
    //MARK: - Loading Functions
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        callApi()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        callapibool = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = ShowTravellerDetailsViewModel(self)
        updateDetailsvm = UpdateTravellerDetailsVM(self)
    }
    
    
    func  callApi(){
        if key == "edit" {
            if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                callShowTravellerDetailsAPI()
            }else {
                fetchCoreDataValues()
            }
        }else {
            setupTV()
        }
    }
    
    
    //MARK: - Show Traveller By Origin
    
    func callShowTravellerDetailsAPI() {
        payload.removeAll()
        payload["origin"] = id
        vm?.CALL_SHOW_TRAVELLER_DETAILS(dictParam: payload)
    }
    
    
    func travellerDetails(response: ShowTravellerByOriginModel) {
        
        edit_title2 = response.data?.title ?? ""
        edit_title1 = ""
        edit_fname = response.data?.first_name ?? ""
        edit_lname = response.data?.last_name ?? ""
        edit_email = response.data?.email ?? ""
        edit_gender = response.data?.gender ?? ""
        edit_dob = convertDateFormat(inputDate: response.data?.date_of_birth ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
        edit_passportno = response.data?.passport_number ?? ""
        edit_experiesOn = convertDateFormat(inputDate: response.data?.passport_expiry_date ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
        edit_issuingCountrycode = response.data?.passport_issuing_country ?? ""
        edit_issuingCountryname = response.data?.passport_issuing_country_name ?? ""
        
        self.title2 = edit_title2
        self.title1 = edit_title1
        self.fname = edit_fname
        self.lname = edit_lname
        self.email = edit_email
        self.gender = edit_gender
        self.dob = edit_dob
        self.passportno = edit_passportno
        self.experiesOn = edit_experiesOn
        self.issuingCountrycode = edit_issuingCountrycode
        self.issuingCountry = edit_issuingCountryname
        self.origin = response.data?.origin ?? ""
        
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        callApi()
    }
    
    
    
    //MARK: - setupUI
    func setupUI() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "Flights" {
                navBar.titlelbl.text = "Traveller Details"
                // setupTV()
            }else {
                navBar.titlelbl.text = "Guest Details"
                setupHotelAddGuestTV()
            }
        }
        
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TextfieldTVCell",
                                         "DropDownTVCell",
                                         "LabelTVCell",
                                         "EmptyTVCell",
                                         "SelectGenderTVCell",
                                         "EnterTravellerDetailsTVCell",
                                         "DobTVCell",
                                         "FrequentFlyerTVCell",
                                         "ExpireOnTVCell"])
    }
    
    
    
    
    //MARK: - setupTV
    func setupTV() {
        
        tablerow.removeAll()
        
        
        if key == "add" {
            
            tablerow.append(TableRow(title:"Male",key:"gender",cellType:.SelectGenderTVCell))
            tablerow.append(TableRow(title:"Frist Name",key: "fname",text: "",buttonTitle: "Frist Name",key1:"add",tempText: "",characterLimit: 1,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Last Name",key: "email",buttonTitle: "Last Name",characterLimit: 2,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",key: "dob",buttonTitle: "Date Of Birth",image: "cal",characterLimit: 3,cellType:.DobTVCell))
            tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            tablerow.append(TableRow(title:"Passport Number",key: "email",buttonTitle: "Passport Number",characterLimit: 5,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Issuing Country",subTitle: "Issuing Country",text: "Country",image: "downarrow",cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: experiesOn,key: "dob",buttonTitle: "Passport Expiry Date",image: "cal",characterLimit: 6,cellType:.ExpireOnTVCell))
            
            //        tablerow.append(TableRow(cellType:.FrequentFlyerTVCell))
            
            
        }else {
            
            
            
            tablerow.append(TableRow(title:gender,key:"gender",cellType:.SelectGenderTVCell));
            tablerow.append(TableRow(title:"Frist Name",key: "fname",text:fname,headerText: title2Code, buttonTitle: "Frist Name", key1:"editfname",tempText: title2Code,characterLimit: 1,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Last Name",key: "email",text:lname,buttonTitle: "Last Name",key1:"editlname",characterLimit: 2,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",key: "dob",text:dob,buttonTitle: "Date Of Birth",key1:"editdob",image: "cal",characterLimit: 3,cellType:.DobTVCell))
            tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            
            tablerow.append(TableRow(title:"Passport Number",key: "email",text:passportno,buttonTitle: "Passport Number",key1:"editpassportno",characterLimit: 5,cellType:.EnterTravellerDetailsTVCell))
            
            tablerow.append(TableRow(title:"Issuing Country",subTitle: "Issuing Country",text: "Country",buttonTitle:issuedCountry,key1:"editissuingcountry", image: "down",cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: experiesOn,key: "dob",text:experiesOn,buttonTitle: "Passport Expiry Date",key1:"editpassportexpirydate",image: "cal",characterLimit: 6,cellType:.ExpireOnTVCell))
            
            //   tablerow.append(TableRow(cellType:.FrequentFlyerTVCell))
        }
        
        
        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: - setupHotelAddGuestTV
    func setupHotelAddGuestTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",subTitle: "",key: "email", text: "1",buttonTitle: fname ?? "First Name ",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: "",key: "email", text: "2",buttonTitle: lname ,tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Passport Number",subTitle: "",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
        //  tablerow.append(TableRow(cellType:.FrequentFlyerTVCell))
        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    
    //MARK: - selectedTitle EnterTravellerDetailsTVCell
    override func selectedTitle(cell:EnterTravellerDetailsTVCell) {
        self.title2 = cell.selectedTitle
        
        switch cell.selectedTitle {
        case "Mr":
            title2Code = "1"
            break
            
        case "Mrs":
            title2Code = "2"
            break
            
        case "Miss":
            title2Code = "3"
            break
            
        case "M":
            title2Code = "4"
            break
            
        default:
            break
        }
        
        print(self.title2)
        print(title2Code)
    }
    
    
    //MARK: - editingTextField UITextField
    override func editingTextField(tf:UITextField) {
        print(tf.text)
        switch tf.tag {
        case 1:
            self.fname = tf.text ?? ""
            break
            
        case 2:
            self.lname = tf.text ?? ""
            break
            
            
        case 5:
            self.passportno = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    //MARK: - didTapOnDropDownBtn DropDownTVCell
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
        self.issuingCountry = cell.issuingCountry ?? ""
        self.issuingCountrycode = cell.issuingCountrycode
        print(self.issuingCountrycode)
    }
    
    
    
    //MARK: - didSelectMaleRadioBtn
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        gender = "Male"
        cell.maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.otherRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        gender = "Female"
        cell.maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        cell.otherRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        
    }
    
    
    override func didSelectOnOthersBtn(cell:SelectGenderTVCell){
        gender = "Others"
        cell.maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.otherRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        
    }
    
    
    //MARK: - donedatePicker TextfieldTVCell
    override func donedatePicker(cell:TextfieldTVCell){
        experiesOn = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:TextfieldTVCell){
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - donedatePicker DobTVCell
    override func donedatePicker(cell: DobTVCell) {
        dob = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: DobTVCell) {
        self.view.endEditing(true)
    }
    
    //MARK: - donedatePicker EnterTravellerDetailsTVCell
    override func donedatePicker(cell:EnterTravellerDetailsTVCell){
        dob = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:EnterTravellerDetailsTVCell){
        self.view.endEditing(true)
    }
    
    
    //MARK: - donedatePicker ExpireOnTVCell
    override func donedatePicker(cell: ExpireOnTVCell) {
        experiesOn = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell: ExpireOnTVCell) {
        self.view.endEditing(true)
    }
    
    
    
    //MARK: - Save Data Locally
    override func didTapOnSaveBtn(cell: SelectGenderTVCell) {
        
        
        if gender == "" {
            showToast(message: "Select Gender")
        }else if title2.isEmpty == true {
            showToast(message: "Select Title")
        }else if fname?.isEmpty == true {
            showToast(message: "Enter First Name")
        }else if (fname?.count ?? 0) < 3 {
            showToast(message: "First Name Should be more than 3 letters")
        }else if lname == "" {
            showToast(message: "Enter Last Name")
        }else if (lname.count ) < 3 {
            showToast(message: "Last Name Should be more than 3 letters")
        }else if dob == "" {
            showToast(message: "Enter Date Of Birth ")
        }else if passportno == "" {
            showToast(message: "Enter Passport Number")
        }else if passportno.isValidPassport() == false {
            showToast(message: "Enter Valid Passport Number")
        }else if issuingCountry == "" {
            showToast(message: "Select Issuing Country")
        }else if experiesOn == "" {
            showToast(message: "Select Passport Expiry Date")
        }else {
            
            if key == "edit" {
                DispatchQueue.main.async {
                    if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                       // self.callUpdateDetailsAPI()
                        
                        self.update()
                    }else {
                        self.update()
                    }
                }
                
            }else {
                DispatchQueue.main.async {
                    
                    if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
                       // self.callAddDateilsAPI()
                        
                        self.saveDetailsLocally()
                    }else {
                        self.saveDetailsLocally()
                    }
                }
            }
            
        }
    }
    
    
    //MARK: - SAVE TRAVELLER DETALS
    
    func callAddDateilsAPI() {
        payload.removeAll()
        
        payload["title"] = self.title2Code
        payload["first_name"] = fname
        payload["last_name"] = lname
        payload["date_of_birth"] = convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
        payload["email"] = email
        payload["gender"] = gender
        payload["passport_user_name"] = "\(fname ?? "") \(lname )"
        payload["passport_nationality"] = issuingCountrycode
        payload["passport_expiry_date"] = convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
        payload["passport_number"] = passportno
        payload["passport_issuing_country"] = issuingCountrycode
        payload["visibility_status"] = "0"
        payload["updated_by_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["passanger_type"] = self.passengerType
        
        updateDetailsvm?.CALL_ADD_TRAVELLER_DETAILS(dictParam: payload)
    }
    
    
    func addTraverllerDetails(response: AddTravellerModel) {
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: response.msg ?? "")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                self.dismiss(animated: true)
            }
        }
    }
    
    
    
    
    //MARK: - UPDATE TRAVELLER DETALS
    func callUpdateDetailsAPI() {
        payload.removeAll()
        
        payload["title"] = self.title2Code
        payload["first_name"] = fname
        payload["last_name"] = lname
        payload["date_of_birth"] = convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
        payload["email"] = email
        payload["gender"] = gender
        payload["passport_user_name"] = "\(fname ?? "") \(lname )"
        payload["passport_nationality"] = issuingCountrycode
        payload["passport_expiry_date"] = convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
        payload["passport_number"] = passportno
        payload["passport_issuing_country"] = issuingCountrycode
        payload["visibility_status"] = "0"
        payload["updated_by_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
        payload["origin"] = self.origin
//        payload["passanger_type"] = self.passengerType

        updateDetailsvm?.CALL_UPDATE_TRAVELLER_DETAILS(dictParam: payload)
    }
    
    func updetedTravellerDetails(response: AddTravellerModel) {
        
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: response.msg ?? "")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                self.dismiss(animated: true)
            }
        }
        
        
    }
    
    
    //MARK: - didTapOnFlayerProgramBtn
    override func didTapOnFlayerProgramBtn(cell: FrequentFlyerTVCell) {
        print(cell.frequentflyerprogramlbl.text)
    }
    
    //MARK: - didTapOnSelectFlayerNoBtn
    override func didTapOnSelectFlayerNoBtn(cell: FrequentFlyerTVCell) {
        print(cell.frequentflyerNumberlbl.text)
    }
    
    //MARK: - SAVEING COREDATA VALUES
    func saveDetailsLocally() {
        
        rno = Int.random(in: 0...500)
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("\(rno)", forKey: "id")
        newUser.setValue(defaults.string(forKey: UserDefaultsKeys.travellerTitle), forKey: "title")
        newUser.setValue(defaults.string(forKey:UserDefaultsKeys.userid), forKey: "userid")
        newUser.setValue(title2, forKey: "title2")
        newUser.setValue(title2Code, forKey: "title2Code")
        newUser.setValue(passengerType, forKey: "passengerType")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(fname, forKey: "fname")
        newUser.setValue(lname, forKey: "lname")
        newUser.setValue(convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "dd-MM-yyyy"), forKey: "dob")
        newUser.setValue(passportno, forKey: "passportno")
        newUser.setValue(convertDateFormat(inputDate: experiesOn, f1: "dd-MM-yyyy", f2: "dd-MM-yyyy"), forKey: "passportexpirydate")
        newUser.setValue(issuingCountrycode, forKey: "passportissuingcountry")
        newUser.setValue(issuingCountry, forKey: "issuingCountryName")
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            print(result)
            details = result
            
            for data in result as! [NSManagedObject]{
               
                edit_title2_code = (data.value(forKey: "title2Code") as? String) ?? ""
                edit_title2 = (data.value(forKey: "title2") as? String) ?? ""
                edit_title1 = (data.value(forKey: "title") as? String) ?? ""
                edit_fname = (data.value(forKey: "fname") as? String) ?? ""
                edit_lname = (data.value(forKey: "lname") as? String) ?? ""
                edit_gender = (data.value(forKey: "gender") as? String) ?? ""
                edit_dob = (data.value(forKey: "dob") as? String) ?? ""
                edit_passportno = (data.value(forKey: "passportno") as? String) ?? ""
                edit_experiesOn = (data.value(forKey: "passportexpirydate") as? String) ?? ""
                edit_issuingCountrycode = (data.value(forKey: "passportissuingcountry") as? String) ?? ""
                edit_issuingCountryname = (data.value(forKey: "issuingCountryName") as? String) ?? ""
                
                self.title2Code = edit_title2_code
                self.title2 = edit_title2_code
                self.title1 = edit_title1
                self.fname = edit_fname
                self.lname = edit_lname
                self.gender = edit_gender
                self.dob = edit_dob
                //     self.nationalitycode = edit_nationalitycode
                self.passportno = edit_passportno
                self.experiesOn = edit_experiesOn
                self.issuingCountrycode = edit_issuingCountrycode
                //      self.nationality = edit_nationalityname
                self.issuingCountry = edit_issuingCountryname
                
            }
            
            DispatchQueue.main.async {[self] in
                setupTV()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    
    
    
    
    //MARK: - UPDATING COREDATA VALUES
    
    func update(){
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(id = %@)", id)
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            let currentUser = results[0] as! NSManagedObject
            
            currentUser.setValue(id, forKey: "id")
            currentUser.setValue(self.title1, forKey: "title")
            currentUser.setValue(self.title2Code, forKey: "title2Code")
            currentUser.setValue(defaults.string(forKey:UserDefaultsKeys.userid), forKey: "userid")
            currentUser.setValue(gender, forKey: "gender")
            currentUser.setValue(fname, forKey: "fname")
            currentUser.setValue(lname, forKey: "lname")
            currentUser.setValue(convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "dd-MM-yyyy"), forKey: "dob")
            currentUser.setValue(passportno, forKey: "passportno")
            currentUser.setValue(convertDateFormat(inputDate: experiesOn, f1: "dd-MM-yyyy", f2: "dd-MM-yyyy"), forKey: "passportexpirydate")
            currentUser.setValue(issuingCountrycode, forKey: "passportissuingcountry")
            currentUser.setValue(issuingCountry, forKey: "issuingCountryName")
            currentUser.setValue(passengerType, forKey: "passengerType")

            do {
                try context.save()
                
            }catch let error as NSError {
                print("Failed")
            }
        }
        catch let error as NSError {
            print("Failed")
        }
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
}
