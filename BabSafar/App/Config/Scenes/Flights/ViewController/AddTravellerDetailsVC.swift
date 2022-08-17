//
//  AddTravellerDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 25/07/22.
//

import UIKit

class AddTravellerDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var navBar: NavBar!
    
    var fname = String()
    var lname = String()
    var nationality = String()
    var documentType = String()
    var passportNumber = String()
    var issuingCountry = String()
    var passportExpiryDate = String()
    var gender = String()
    var tablerow = [TableRow]()
    static var newInstance: AddTravellerDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddTravellerDetailsVC
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
            if selectedTab == "flights" {
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
    
    func setupTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",key: "email", text: "1",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Document Type",key: "email", text: "3",tempText: "XN1247815",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Issuing Country",subTitle: "Country",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:15,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: "12-06-2026",image: "cal",moreData: ["12-06-2026","12-06-2026"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"save",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    func setupHotelAddGuestTV() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"Frist Name",key: "email", text: "1",tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",key: "email", text: "2",tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Nationality",subTitle: "Nationality",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Travel document*",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Document Type",key: "email", text: "3",tempText: "XN1247815",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Passport Number",key: "email", text: "4",tempText: "1458-125-12467",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Issuing Country",subTitle: "Country",image: "downarrow",moreData: ["1","2"],cellType:.DropDownTVCell))
        tablerow.append(TableRow(height:15,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passport Expiry Date",subTitle: "12-06-2026",image: "cal",moreData: ["12-06-2026","12-06-2026"],cellType:.DropDownTVCell))
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
            self.passportNumber = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
        switch cell.titlelbl.text {
        case "Nationality":
            self.nationality = cell.dropdownlbl.text ?? ""
            break
            
        case "Issuing Country":
            self.issuingCountry = cell.dropdownlbl.text ?? ""
            break
            
        case "Passport Expiry Date":
            self.passportExpiryDate = cell.dropdownlbl.text ?? ""
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
        }else if passportNumber == "" {
            showToast(message: "Enter Passport Number")
        }else if issuingCountry == "" {
            showToast(message: "Select Issuing Country")
        }else if passportExpiryDate == "" {
            showToast(message: "Select Passport Expiry Date")
        }else {
            
            print("Call API====>")
            
            
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected) {
                if selectedTab == "flights" {
                    if let addchild = defaults.string(forKey: UserDefaultsKeys.addTarvellerDetails) {
                        if addchild == "addadult" {
                            adultsArray.append(fname)
                        }else {
                            childArray.append(fname)
                        }
                    }
                }else {
                    if let addchild = defaults.string(forKey: UserDefaultsKeys.addTarvellerDetails) {
                        if addchild == "hoteladult" {
                            adultsArray.append(fname)
                        }else {
                            childArray.append(fname)
                        }
                    }
                }
            }
            
            
            
            NotificationCenter.default.post(name: NSNotification.Name("addAdultsDetails"), object: fname)
            dismiss(animated: false)
        }
    }
    
    
    
    
}
