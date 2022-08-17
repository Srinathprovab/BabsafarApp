//
//  MoreDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class MoreDetailsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    
    static var newInstance: MoreDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MoreDetailsVC
        return vc
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "More Details"
        nav.backBtnView.isHidden = true
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["AboutusTVCell","EmptyTVCell"])
        
        setuptv()
        
    }
    
    func setuptv() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"About Us",cellType:.AboutusTVCell))
        tablerow.append(TableRow(title:"Terms & Conditions",cellType:.AboutusTVCell))
        tablerow.append(TableRow(title:"Cookies Policy",cellType:.AboutusTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AboutusTVCell {
            switch cell.titlelbl.text {
            case "About Us":
                gotoAboutUsVC(title: "About Us", url: "https://apple.com")
                break
                
            case "Terms & Conditions":
                gotoAboutUsVC(title: "Terms & Conditions", url: "https://www.facebook.com")
                break
                
            case "Cookies Policy":
                gotoAboutUsVC(title: "Cookies Policy", url: "https://www.gmail.com")
                break
                
            default:
                break
            }
        }
    }
    
    
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.urlString = url
        vc.titleString = title
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
}
