//
//  MyAccountVC.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit
import MobileCoreServices
import Alamofire



class MyAccountVC: BaseTableVC, ProfileDetailsViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var changeProfileImgView: UIView!
    @IBOutlet weak var camImg: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    static var newInstance: MyAccountVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MyAccountVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var gender = String()
    var fname = String()
    var lname = String()
    var mobile = String()
    var email = String()
    var address = String()
    var address1 = String()
    var countryname = String()
    var statename = String()
    var cityname = String()
    var pincode = String()
    var dob = String()
    var pass = String()
    
    var viewmodel:ProfileDetailsViewModel?
    var payload = [String:Any]()
    var showKey = "profile"
    var pickerbool = false
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
        
        
        if pickerbool == true {
            
        }else {
            callApi()
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
    
    
    //MARK: - callApi
    func callApi() {
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            navHeight.constant = 180
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            self.changeProfileImgView.isHidden = false
            self.profileImgView.isHidden = false
            camImg.isHidden = false
            nav.filterBtnView.isHidden = false
            
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            viewmodel?.CallGetProileDetails_API(dictParam: payload)
            
            
        }else {
            navHeight.constant = 90
            self.changeProfileImgView.isHidden = true
            self.profileImgView.isHidden = true
            camImg.isHidden = true
            nav.filterBtnView.isHidden = true
            TableViewHelper.EmptyMessage(message: "Please Login To View Your Profile Details", tableview: commonTableView, vc: self)
            gotoLoginVC()
            
        }
    }
    
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    //MARK: - getProfileDetails
    
    func getProfileDetails(response: ProfileDetailsModel) {
        
        pdetails = response.data
        fname = pdetails?.first_name ?? ""
        lname = pdetails?.last_name ?? ""
        mobile = pdetails?.phone ?? ""
        email = pdetails?.email ?? ""
        address = pdetails?.address ?? ""
        address1 = pdetails?.address2 ?? ""
        countryname = pdetails?.country_name ?? ""
        statename = pdetails?.state_name ?? ""
        cityname = pdetails?.city_name ?? ""
        pincode = pdetails?.pin_code ?? ""
        dob = convertDateFormat(inputDate: pdetails?.date_of_birth ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
        gender = pdetails?.gender ?? ""
        
        if pdetails?.image?.isEmpty == false {
            self.profileImg.sd_setImage(with: URL(string: pdetails?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
        }
        DispatchQueue.main.async {[self] in
            nav.titlelbl.text = "My Account"
            changeProfileImgView.isHidden = true
            appendProfileTvcells(str: "profile")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
        viewmodel = ProfileDetailsViewModel(self)
    }
    
    
    func setupUI() {
        
        
        changeProfileImgView.backgroundColor = .WhiteColor
        profileImgView.backgroundColor = .WhiteColor
        changeProfileImgView.backgroundColor = .WhiteColor
        changeProfileImgView.addBottomBorderWithColor(color: .AppLabelColor, width: 0.8)
        
        profileImgView.layer.borderWidth = 4
        profileImgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        
        profileImgView.layer.cornerRadius = 50
        profileImgView.clipsToBounds = true
        
        profileImg.layer.cornerRadius = 45
        profileImg.clipsToBounds = true
        
        
        changeProfileImgView.layer.cornerRadius = 20
        changeProfileImgView.clipsToBounds = true
        changeProfileBtn.setTitle("", for: .normal)
        camImg.image = UIImage(named: "cam")
    }
    
    func setupTV() {
        
        nav.backBtnView.isHidden = true
        nav.filterImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
        nav.filterBtn.addTarget(self, action: #selector(didTapOnEditAccountBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["TextfieldTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","EmptyTVCell","SelectGenderTVCell"])
        
        
    }
    
    
    func appendProfileTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:gender,key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"First Name",subTitle: pdetails?.first_name ?? "",key: str, text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: pdetails?.last_name ?? "",key: str, text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number",subTitle: pdetails?.phone ?? "",key: str, text: "3", tempText: "+961",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email address",subTitle: pdetails?.email ?? "",key: str, text: "4", tempText: "Address",cellType:.TextfieldTVCell))
        
        //        tablerow.append(TableRow(title:"Address",subTitle: pdetails?.address ?? "",key: str, text: "5", tempText: "Address",cellType:.TextfieldTVCell))
        //
        //        tablerow.append(TableRow(title:"Address2",subTitle: pdetails?.address2 ?? "",key: str, text: "6", tempText: "Address2",cellType:.TextfieldTVCell))
        //
        //        tablerow.append(TableRow(title:"Country Name",subTitle: pdetails?.country_name ?? "",key: str, text: "7", tempText: "Country Name",cellType:.TextfieldTVCell))
        //
        //        tablerow.append(TableRow(title:"State Name",subTitle: pdetails?.state_name ?? "",key: str, text: "8", tempText: "State Name",cellType:.TextfieldTVCell))
        //
        //
        //        tablerow.append(TableRow(title:"City Name",subTitle: pdetails?.city_name ?? "",key: str, text: "9", tempText: "City Name",cellType:.TextfieldTVCell))
        //
        //
        //        tablerow.append(TableRow(title:"Pincode",subTitle: pdetails?.pin_code ?? "",key: str, text: "10", tempText: "City Name",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Date Of Birth",subTitle: dob,key: str, text: "11",key1: "pdob", tempText: "Date Of Birth",cellType:.TextfieldTVCell))
        
        
        
        if showKey == "edit" {
            //   tablerow.append(TableRow(title:"Password",subTitle: pass,key: "profilepass", text: "5", tempText: "Password",cellType:.TextfieldTVCell))
            
            tablerow.append(TableRow(title:"Update",key: "filterbtn",cellType:.ButtonTVCell))
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
        case 2:
            lname = tf.text ?? ""
            break
        case 3:
            mobile = tf.text ?? ""
            break
        case 4:
            email = tf.text ?? ""
            break
            
        case 5:
            address = tf.text ?? ""
            break
        case 6:
            address1 = tf.text ?? ""
            break
        case 7:
            countryname = tf.text ?? ""
            break
        case 8:
            statename = tf.text ?? ""
            break
            
        case 9:
            cityname = tf.text ?? ""
            break
        case 10:
            pincode = tf.text ?? ""
            break
        case 11:
            dob = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        gender = cell.gender
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        gender = cell.gender
    }
    
    override func didTapOnForGetPassword(cell:TextfieldTVCell){
        guard let vc = CreateNewPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @objc func didTapOnEditAccountBtn(_ sender: UIButton) {
        showKey = "edit"
        changeProfileImgView.isHidden = false
        appendProfileTvcells(str: "profiledit")
    }
    
    @IBAction func didTapOnChangeProfilePhotoBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func donedatePicker(cell:TextfieldTVCell){
        dob = cell.txtField.text ?? ""
        self.view.endEditing(true)
    }
    override func cancelDatePicker(cell:TextfieldTVCell){
        self.view.endEditing(true)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        if gender == "" {
            showToast(message: "Enter Gender")
        }else if fname == "" {
            showToast(message: "Enter First Name")
        }else if lname == "" {
            showToast(message: "Enter Last Name")
        }else if mobile == "" {
            showToast(message: "Enter Mobile Number")
        }else if mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile Number")
        }else if email == "" {
            showToast(message: "Enter Email")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email")
        }
        
        //        else if address.isEmpty == true {
        //            showToast(message: "Enter Address")
        //        }else if countryname.isEmpty == true {
        //            showToast(message: "Enter Country Name")
        //        }else if statename.isEmpty == true {
        //            showToast(message: "State Name")
        //        }else if cityname.isEmpty == true {
        //            showToast(message: "City Name")
        //        }else if pincode.isEmpty == true {
        //            showToast(message: "Enter PinCode")
        //        }else if dob.isEmpty == true {
        //            showToast(message: "Enter Date Of Birth")
        //        }
        
        
        else {
            
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["phone"] = mobile
            payload["email"] = email
            payload["address"] = address
            payload["address2"] = address1
            payload["country_name"] = countryname
            payload["state_name"] = statename
            payload["city_name"] = cityname
            payload["pin_code"] = pincode
            payload["date_of_birth"] = convertDateFormat(inputDate: dob, f1: "dd-MM-yyyy", f2: "yyyy-MM-dd")
            payload["gender"] = gender
            
            callUpdateProfileAPI()
        }
    }
    
    
    func updateProfileDetails(response: ProfileDetailsModel) {
        pdetails = response.data
        showToast(message: response.msg ?? "")
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.showKey = "profile"
            self.appendProfileTvcells(str: "profile")
        }
    }
    
    
    func callUpdateProfileAPI() {
        
        self.viewmodel?.view.showLoader()
        
        AF.upload(multipartFormData: { MultipartFormData  in
            
            for(key,value) in self.payload{
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            if let img =  self.profileImg.image {
                if let imageData = img.jpegData(compressionQuality: 0.4) {
                    MultipartFormData.append(imageData, withName: "image", fileName: "\(Date()).jpeg", mimeType: "image/jpeg")
                }
            }
            
            
        }, to: "\(BASE_URL)user/mobile_profile").responseDecodable(of: ProfileDetailsModel.self){ resp in
            
            switch resp.result{
            case let .success(data):
                print("AF.upload ===== > \(data)")
                self.viewmodel?.view.hideLoader()
                self.showToast(message: data.msg ?? "")
                DispatchQueue.main.async {
                    self.changeProfileImgView.isHidden = true
                    self.showKey = "profile"
                    self.appendProfileTvcells(str: "profile")
                }
                
                break
                
            case .failure(let encodingError):
                self.viewmodel?.view.hideLoader()
                print("ERROR RESPONSE: \(encodingError)")
                
            }
            
        }
        
    }
}



extension MyAccountVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImg.image = tempImage
        }
        
        self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
}
