//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData

class AddTravellerDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    // @IBOutlet weak var navheight: NSLayoutConstraint!
    
    //MARK: - variables Decleration
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
    var nationality = String()
    var issuingCountry = String()
    var nationalitycode = String()
    var nationalityCountryName = String()
    var issuingCountrycode = String()
    var issuingCountryName = String()
    var mobileno = String()
    var email = String()
    var textFieldText = ""
    var key = String()
    var id = String()
    var title1 = String()
    var title2 = String()
    var tablerow = [TableRow]()
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    
    
    
    
    //MARK: - Loading Functions
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        callApi()
    }
    
    func  callApi(){
        if key == "edit" {
            fetchCoreDataValues()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    
    //MARK: - setupUI
    func setupUI() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "Flights" {
                navBar.titlelbl.text = "Traveller Details"
                setupTV()
            }else {
                navBar.titlelbl.text = "Guest Details"
                // setupHotelAddGuestTV()
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
                                         "ExpireOnTVCell"])
    }
    
    
    
    
    //MARK: - setupTV
    func setupTV() {
        
        tablerow.removeAll()
        
        
        if key == "add" {
            
            tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
            tablerow.append(TableRow(title:"Frist Name",key: "fname",text: "",buttonTitle: "Frist Name",key1:"add",characterLimit: 1,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Last Name",key: "email",buttonTitle: "Last Name",characterLimit: 2,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",key: "dob",buttonTitle: "Date Of Birth",image: "cal",characterLimit: 3,cellType:.DobTVCell))
            tablerow.append(TableRow(title:"Nationality",text: "Nationality",image: "downarrow",cellType:.DropDownTVCell))
            tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            
            tablerow.append(TableRow(title:"Document Type",key: "email",buttonTitle: "Document Type",characterLimit: 4,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Passport Number",key: "email",buttonTitle: "Passport Number",characterLimit: 5,cellType:.EnterTravellerDetailsTVCell))
            
            tablerow.append(TableRow(title:"Issuing Country",subTitle: "",text: "Country",image: "downarrow",cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: experiesOn,key: "dob",buttonTitle: "Passport Expiry Date",image: "cal",characterLimit: 6,cellType:.ExpireOnTVCell))
            
        }else {
            
            
            
            tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
            tablerow.append(TableRow(title:"Frist Name",key: "fname",text:fname,headerText: title2, buttonTitle: "Frist Name", key1:"editfname",characterLimit: 1,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Last Name",key: "email",text:lname,buttonTitle: "Last Name",key1:"editlname",characterLimit: 2,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Date Of Birth",key: "dob",text:dob,buttonTitle: "Date Of Birth",key1:"editdob",image: "cal",characterLimit: 3,cellType:.DobTVCell))
            tablerow.append(TableRow(title:"Nationality",text: "Nationality",buttonTitle:nationality,key1:"editnationality", image: "downarrow",cellType:.DropDownTVCell))
            tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
            
            tablerow.append(TableRow(title:"Document Type",key: "email",text:"hhhh",buttonTitle: "Document Type",key1:"edit",characterLimit: 4,cellType:.EnterTravellerDetailsTVCell))
            tablerow.append(TableRow(title:"Passport Number",key: "email",text:passportno,buttonTitle: "Passport Number",key1:"editpassportno",characterLimit: 5,cellType:.EnterTravellerDetailsTVCell))
            
            tablerow.append(TableRow(title:"Issuing Country",subTitle: "",text: "Country",buttonTitle:issuedCountry,key1:"editissuingcountry", image: "downarrow",cellType:.DropDownTVCell))
            tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: experiesOn,key: "dob",text:experiesOn,buttonTitle: "Passport Expiry Date",key1:"editpassportexpirydate",image: "cal",characterLimit: 6,cellType:.ExpireOnTVCell))
            
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
        tablerow.append(TableRow(title:"Document Type",subTitle: "",key: "email", text: "3",tempText: "XN1247815",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Passport Number",subTitle: "",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
        
        
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
        print(self.title2)
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
            
            
        case 4:
            self.documentType = tf.text ?? ""
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
        switch cell.titlelbl.text {
        case "Nationality":
            self.nationality = cell.nationality ?? ""
            self.nationalitycode = cell.nationalitycode
            print(self.nationalitycode)
            print(self.nationality)
            break
            
        case "Issuing Country":
            self.issuingCountry = cell.issuingCountry ?? ""
            self.issuingCountrycode = cell.issuingCountrycode
            print(self.issuingCountrycode)
            break
            
        default:
            break
        }
    }
    
    
    
    //MARK: - donedatePicker TextfieldTVCell
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        gender = "Male"
        cell.maleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        gender = "Female"
        cell.maleRadioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        cell.femaleRadioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal)
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
        }else if lname == "" {
            showToast(message: "Enter Last Name")
        }else if dob == "" {
            showToast(message: "Enter Date Of Birth ")
        }else if nationality == "" {
            showToast(message: "Select Nationality")
        }else if documentType == "" {
            showToast(message: "Enter DocumentType")
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
                
                
                print("edit .....")
                DispatchQueue.main.async {
                    self.update()
                }
            }else {
                DispatchQueue.main.async {
                    self.saveDetailsLocally()
                }
            }
            
        }
    }
    
    
    
    
    func saveDetailsLocally() {
        
        rno = Int.random(in: 0...500)
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("\(rno)", forKey: "id")
        newUser.setValue(defaults.string(forKey: UserDefaultsKeys.travellerTitle), forKey: "title")
        newUser.setValue(defaults.string(forKey:UserDefaultsKeys.userid), forKey: "userid")
        newUser.setValue(title2, forKey: "title2")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(fname, forKey: "fname")
        newUser.setValue(lname, forKey: "lname")
        newUser.setValue(convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd"), forKey: "dob")
        newUser.setValue(nationalitycode, forKey: "nationality")
        newUser.setValue(passportno, forKey: "passportno")
        newUser.setValue(convertDateFormat(inputDate: experiesOn, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd"), forKey: "passportexpirydate")
        newUser.setValue(issuingCountrycode, forKey: "passportissuingcountry")
        newUser.setValue(nationality, forKey: "nationalityName")
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
                print("fname ====== >\((data.value(forKey: "fname") as? String) ?? "")")
                
                edit_title2 = (data.value(forKey: "title2") as? String) ?? ""
                edit_title1 = (data.value(forKey: "title") as? String) ?? ""
                edit_fname = (data.value(forKey: "fname") as? String) ?? ""
                edit_lname = (data.value(forKey: "lname") as? String) ?? ""
                edit_gender = (data.value(forKey: "gender") as? String) ?? ""
                edit_dob = (data.value(forKey: "dob") as? String) ?? ""
                edit_nationalitycode = (data.value(forKey: "nationality") as? String) ?? ""
                edit_passportno = (data.value(forKey: "passportno") as? String) ?? ""
                edit_experiesOn = (data.value(forKey: "passportexpirydate") as? String) ?? ""
                edit_issuingCountrycode = (data.value(forKey: "passportissuingcountry") as? String) ?? ""
                edit_nationalityname = (data.value(forKey: "nationalityName") as? String) ?? ""
                edit_issuingCountryname = (data.value(forKey: "issuingCountryName") as? String) ?? ""
                
                self.title2 = edit_title2
                self.title1 = edit_title1
                self.fname = edit_fname
                self.lname = edit_lname
                self.gender = edit_gender
                self.dob = edit_dob
                self.nationalitycode = edit_nationalitycode
                self.passportno = edit_passportno
                self.experiesOn = edit_experiesOn
                self.issuingCountrycode = edit_issuingCountrycode
                self.nationality = edit_nationalityname
                self.issuingCountry = edit_issuingCountryname
                
            }
            
            DispatchQueue.main.async {[self] in
                setupTV()
            }
        } catch {
            print("Failed")
        }
    }
    
    
    
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    
    func update(){
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(id = %@)", id)
        request.predicate = predicate
        do {
            let results =
            try context.fetch(request)
            let currentUser = results[0] as! NSManagedObject
            
            currentUser.setValue(id, forKey: "id")
            currentUser.setValue(self.title1, forKey: "title")
            currentUser.setValue(defaults.string(forKey:UserDefaultsKeys.userid), forKey: "userid")
            currentUser.setValue(gender, forKey: "gender")
            currentUser.setValue(fname, forKey: "fname")
            currentUser.setValue(lname, forKey: "lname")
            currentUser.setValue(convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd"), forKey: "dob")
            currentUser.setValue(nationalitycode, forKey: "nationality")
            currentUser.setValue(passportno, forKey: "passportno")
            currentUser.setValue(convertDateFormat(inputDate: experiesOn, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd"), forKey: "passportexpirydate")
            currentUser.setValue(issuingCountrycode, forKey: "passportissuingcountry")
            
            currentUser.setValue(nationality, forKey: "nationalityName")
            currentUser.setValue(issuingCountry, forKey: "issuingCountryName")
            
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
