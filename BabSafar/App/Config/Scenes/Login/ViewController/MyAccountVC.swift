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
    
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
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
    var fileName = String()
    var fileType = String()
    var fileData = Data()
    var yourimageView = UIImage()
    var imgUrl = NSURL()
    var viewmodel:ProfileDetailsViewModel?
    var payload = [String:Any]()
    var showKey = "profile"
    
    override func viewWillAppear(_ animated: Bool) {
        print("====  viewWillAppear MyAccountVC =======")
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/user/"
        payload["user_id"] = "2075"
        viewmodel?.CallGetProileDetails_API(dictParam: payload)
    }
    
    var pdetails:ProfileDetails?
    func getProfileDetails(response: ProfileDetailsModel) {
        print("==== getProfileDetails =======")
        print(response)
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
        dob = pdetails?.date_of_birth ?? ""
        gender = pdetails?.gender ?? ""
        
        if pdetails?.image?.isEmpty == false {
            self.profileImg.sd_setImage(with: URL(string: pdetails?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
        }
        DispatchQueue.main.async {[self] in
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
        profileImgView.layer.borderWidth = 1
        profileImgView.layer.borderColor = UIColor.AppBorderColor.cgColor
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
        nav.titlelbl.text = "My Account"
        nav.backBtnView.isHidden = true
        nav.filterBtnView.isHidden = false
        nav.filterImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
        nav.filterBtn.addTarget(self, action: #selector(didTapOnEditAccountBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["TextfieldTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","EmptyTVCell","SelectGenderTVCell"])
        
        
    }
    
    
    func appendProfileTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"male",key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"First Name",subTitle: pdetails?.first_name ?? "",key: str, text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: pdetails?.last_name ?? "",key: str, text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number",subTitle: pdetails?.phone ?? "",key: str, text: "3", tempText: "+961",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email address",subTitle: pdetails?.email ?? "",key: str, text: "4", tempText: "Address",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Address",subTitle: pdetails?.address ?? "",key: str, text: "5", tempText: "Address",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Address2",subTitle: pdetails?.address2 ?? "",key: str, text: "6", tempText: "Address2",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Country Name",subTitle: pdetails?.country_name ?? "",key: str, text: "7", tempText: "Country Name",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"State Name",subTitle: pdetails?.state_name ?? "",key: str, text: "8", tempText: "State Name",cellType:.TextfieldTVCell))
        
        
        tablerow.append(TableRow(title:"City Name",subTitle: pdetails?.city_name ?? "",key: str, text: "9", tempText: "City Name",cellType:.TextfieldTVCell))
        
        
        tablerow.append(TableRow(title:"Pincode",subTitle: pdetails?.pin_code ?? "",key: str, text: "10", tempText: "City Name",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Date Of Birth",subTitle: pdetails?.date_of_birth ?? "",key: str, text: "11",key1: "pdob", tempText: "Date Of Birth",cellType:.TextfieldTVCell))
        
        
        
        if showKey == "edit" {
            //   tablerow.append(TableRow(title:"Password",subTitle: pass,key: "profilepass", text: "5", tempText: "Password",cellType:.TextfieldTVCell))
            
            tablerow.append(TableRow(title:"Update",cellType:.ButtonTVCell))
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
        appendProfileTvcells(str: "profiledit")
    }
    
    @IBAction func didTapOnChangeProfilePhotoBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCamera()
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
        }else if email == "" {
            showToast(message: "Enter Email")
        }else if email.isValidEmail == false {
            showToast(message: "Enter Valid Email")
        }else if address.isEmpty == true {
            showToast(message: "Enter Address")
        }else if countryname.isEmpty == true {
            showToast(message: "Enter Country Name")
        }else if statename.isEmpty == true {
            showToast(message: "State Name")
        }else if cityname.isEmpty == true {
            showToast(message: "City Name")
        }else if pincode.isEmpty == true {
            showToast(message: "Enter PinCode")
        }else if dob.isEmpty == true {
            showToast(message: "Enter Date Of Birth")
        }
       
        
        else {
            
            BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/user/"
            payload["user_id"] = "2075"
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
            payload["date_of_birth"] = dob
            payload["gender"] = gender
            
            viewmodel?.UpdateProfileDetails(dictParam: payload)
         //   callUpdateProfileAPI()
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
            
            
            
            MultipartFormData.append((self.profileImg.image ?? UIImage()).jpegData(compressionQuality: 0.1)!, withName: "image" , fileName: self.fileName, mimeType: self.fileType)
            
            for(key,value) in self.payload{
                
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)}
            
        }, to: "https://provabdevelopment.com/alghanim_new/mobile_webservices/mobile/index.php/user/\(ApiEndpoints.mobileprofile)").responseDecodable(of: ProfileDetailsModel.self){ resp in
            
            switch resp.result{
            case let .success(data):
                print("AF.upload ===== >")
               
               
                self.pdetails = data.data
                self.showToast(message: data.msg ?? "")
                
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
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
    
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = [(kUTTypePNG as String), (kUTTypeJPEG as String), (kUTTypeImage as String)] // This is an array - you can add other format Strings as well
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.profileImg.image = pickedImage
        }
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            fileName = url.lastPathComponent
            fileType = url.pathExtension
            imgUrl = url as NSURL
            
            defaults.set(fileName, forKey: "fileName")
            defaults.set(fileType, forKey: "fileType")
            // defaults.set(imgUrl, forKey: "imgUrl")
            
            
            
            print(imgUrl)
            print(fileName)
            print(fileType)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
