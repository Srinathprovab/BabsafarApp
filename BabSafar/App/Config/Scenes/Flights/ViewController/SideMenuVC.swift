//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SideMenuVC: BaseTableVC {
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupMenuTVCells()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .left
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .left:
                dismiss(animated: false)
            default:
                break
            }
        }
    }
    
    
    
    func setupMenuTVCells() {
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell","LabelTVCell","EmptyTVCell"])
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"My Bookings",key: "menu", image: "bookings",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Free Cancellation",key: "menu", image: "feecancel",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Customer Support",key: "menu", image: "customer",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Our Products",key: "ourproducts", image: "",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Flights",key: "menu", image: "bookings",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Hotels",key: "menu", image: "hotel",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Insurance",key: "menu", image: "insurence",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Visa",key: "menu", image: "visa",cellType:.LabelTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Logout",key: "menu", image: "logout",cellType:.LabelTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
        
    }
    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    
}



extension SideMenuVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LabelTVCell {
            
            switch cell.titlelbl.text {
            case "My Bookings":
                guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                vc.selectedIndex = 1
                present(vc, animated: true)
                break
                
            case "Flights":
                guard let vc = SearchFlightsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
                break
                
            case "Hotels":
                guard let vc = SearchHotelsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
                break
                
            case "Insurance":
                guard let vc = InsuranceVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
                break
                
            case "Visa":
                guard let vc = VisaEnduiryVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true)
                break
                
            default:
                break
            }
        }
    }
    
    
}
