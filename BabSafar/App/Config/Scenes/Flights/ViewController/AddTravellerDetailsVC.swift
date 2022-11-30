//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit
import CoreData

class AddTravellerDetailsVC: BaseTableVC, AllCountryCodeListViewModelDelegate {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    var fname:String?
    var lname = String()
   
    var documentType = String()
    var passportno = String()
    var passportExpiryDate = String()
    var gender = String()
    var ptitle = String()
    var issuedCountry = String()
    var experiesOn = String()
    var rno = Int()
    var nationality = String()
    var issuingCountry = String()
    var nationalitycode = String()
    var issuingCountrycode = String()
    var mobileno = String()
    var email = String()
    var viewmodel:AllCountryCodeListViewModel?
    
    var tablerow = [TableRow]()
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        callGetCointryListAPI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = AllCountryCodeListViewModel(self)
    }
    
    
    func setupUI() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "Flights" {
                navBar.titlelbl.text = "Traveller Details"
                setupTV()
            }else {
                navBar.titlelbl.text = "Guest Details"
                setupHotelAddGuestTV()
            }
        }
        
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["TextfieldTVCell","DropDownTVCell","LabelTVCell","EmptyTVCell","SelectGenderTVCell"])
    }
    
    
    
    func callGetCointryListAPI() {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    
   
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
        
        DispatchQueue.main.async {
            self.commonTableView.reloadData()
        }
    }
    
    func setupTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",key: "email", text: "1",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",text: "Nationality",image: "downarrow",cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Document Type",key: "email", text: "3",tempText: "XN1247815",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
 
        tablerow.append(TableRow(title:"Issuing Country",text: "Country",image: "downarrow",cellType:.DropDownTVCell))
        tablerow.append(TableRow(title:"Passport Expiry Date",key: "cal", text: "6",tempText: "Passport Expiry Date",cellType:.TextfieldTVCell))

        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Contact Details*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Mobile No",key: "mob", text: "12",tempText: "Mobile No",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email",key: "email", text: "11",tempText: "Email Id",cellType:.TextfieldTVCell))

        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupHotelAddGuestTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",key: "email", text: "1",buttonTitle: fname ?? "email",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Document Type",key: "email", text: "3",tempText: "XN1247815",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
       
 
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf:UITextField) {
        switch tf.tag {
        case 1:
            self.fname = tf.text ?? ""
            break
            
        case 2:
            self.lname = tf.text ?? ""
            break
            
        case 3:
            self.documentType = tf.text ?? ""
            break
            
        case 4:
            self.passportno = tf.text ?? ""
            break
            
            
        case 6:
            self.passportExpiryDate = tf.text ?? ""
            break
            
       
        case 12:
            self.mobileno = tf.text ?? ""
            break
            
        case 11:
            self.email = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
        switch cell.titlelbl.text {
        case "Nationality":
            self.nationality = cell.nationality ?? ""
            self.nationalitycode = cell.nationalitycode
            print(self.nationalitycode)
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
    
    
    override func donedatePicker(cell:TextfieldTVCell){
        experiesOn = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    
    
    override func cancelDatePicker(cell:TextfieldTVCell){
        self.view.endEditing(true)
    }
    
    override func didTapOnSaveBtn(cell: SelectGenderTVCell) {
        
        
        if gender == "" {
            showToast(message: "Select Gender")
        }else if fname == "" {
            showToast(message: "Enter First Name")
        }else if lname == "" {
            showToast(message: "Enter Last Name")
        }else if nationality == "" {
            showToast(message: "Select Nationality")
        }else if documentType == "" {
            showToast(message: "Enter DocumentType")
        }else if passportno == "" {
            showToast(message: "Enter Passport Number")
        }else if issuingCountry == "" {
            showToast(message: "Select Issuing Country")
        }else if passportExpiryDate == "" {
            showToast(message: "Select Passport Expiry Date")
        }else if mobileno.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email Id")
        }else if email.isValidEmail == false {
            showToast(message: "Enter Valid Email Id")
        }else {
            
            print("Call API====>")
            
            DispatchQueue.main.async {
                self.saveDetailsLocally()
            }
            
        }
    }
    
    
    
    
    func saveDetailsLocally() {
        
        rno = Int.random(in: 0...500)
        
        let entity = NSEntityDescription.entity(forEntityName: "PassengerDetails", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("\(rno)", forKey: "id")
        newUser.setValue(ptitle, forKey: "title")
        newUser.setValue(defaults.string(forKey:UserDefaultsKeys.userid), forKey: "userid")
        newUser.setValue(gender, forKey: "gender")
        newUser.setValue(fname, forKey: "fname")
        newUser.setValue(lname, forKey: "lname")
        newUser.setValue(nationalitycode, forKey: "nationality")
        newUser.setValue(passportno, forKey: "passportno")
        newUser.setValue(experiesOn, forKey: "passportexpirydate")
        newUser.setValue(issuingCountrycode, forKey: "passportissuingcountry")
        newUser.setValue(mobileno, forKey: "mobileno")
        newUser.setValue(email, forKey: "email")
        
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        
        
        
        dismiss(animated: true)
        
    }
    
    
    
    
    
}
