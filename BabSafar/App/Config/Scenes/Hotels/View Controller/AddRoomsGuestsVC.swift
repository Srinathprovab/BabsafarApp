//
//  AddRoomsGuestsVC.swift
//  BabSafar
//
//  Created by FCI on 17/12/22.
//

import UIKit


var totaladultsCount = Int()
var totalchildCount = Int()


class AddRoomsGuestsVC: BaseTableVC {
    
    static var newInstance: AddRoomsGuestsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddRoomsGuestsVC
        return vc
    }
    var tableRow = [TableRow]()
    var roomCountArray = [Int]()
    var roomcount = 1
    var adultsCountArray = [1]
    var childCountArray = [Int]()
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.set(1, forKey: UserDefaultsKeys.roomcount)
        roomCountArray.append(roomcount)
        appendTVCells()
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        commonTableView.registerTVCells(["AddRoomsGuestsTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "LabelTVCell"])
        
    }
    
    
    func appendTVCells() {
        tableRow.removeAll()
        
        tableRow.append(TableRow(title:"Add  Rooms & Guests  ",key: "showbtn",cellType:.LabelTVCell))
        
        roomCountArray.forEach { i in
            tableRow.append(TableRow(title:"Room \(i)",key: "show",characterLimit: i,cellType: .AddRoomsGuestsTVCell))
        }
        
        
        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        if roomcount == 4 {
            
        }else {
            tableRow.append(TableRow(title:"+ Add Room",key:"addroom",cellType:.ButtonTVCell))
        }
        
        
        tableRow.append(TableRow(height:100,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",key: "done",bgColor: .AppBtnColor,cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:300,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
    
    override func closeBtnAction(cell: AddRoomsGuestsTVCell) {
        roomCountArray.remove(at: (cell.indexPath?.row ?? 0) - 1)
        tableRow.remove(at: cell.indexPath?.row ?? 0)
        roomcount = roomcount - 1
        //        cell.adultcount = 1
        //        cell.adultsCountlbl.text = "1"
        //        cell.childCount = 0
        //        cell.childrenCountlbl.text = "1"
        appendTVCells()
    }
    
    
    
    override func adultsIncrementButtonAction(cell:AddRoomsGuestsTVCell){
        if cell.adultcount >= 1 &&  cell.adultcount < 4{
            cell.adultcount += 1
            cell.adultsCountlbl.text = "\(cell.adultcount)"
            adultsCountArray.append(cell.adultcount)
        }else {
            showToast(message: "Adults Not More Than 4")
        }
        
        print(adultsCountArray.count)
    }
    
    override func adultsDecrementBtnAction(cell:AddRoomsGuestsTVCell){
        if cell.adultcount > 1 {
            cell.adultcount -= 1
            cell.adultsCountlbl.text = "\(cell.adultcount)"
            
            adultsCountArray.removeLast()
        }else {
            showToast(message: "")
        }
        
        print(adultsCountArray.count)
    }
    
    override func childrenIncrementButtonAction(cell:AddRoomsGuestsTVCell){
        if cell.childCount >= 0 &&  cell.childCount < 2{
            cell.childCount += 1
            cell.childrenCountlbl.text = "\(cell.childCount)"
            childCountArray.append(cell.childCount)
        }else {
            showToast(message: "Childerns Not More Than 2")
        }
        
        print(childCountArray.count)
    }
    
    override func childrenDecrementBtnAction(cell:AddRoomsGuestsTVCell){
        if cell.childCount > 0 {
            cell.childCount -= 1
            cell.childrenCountlbl.text = "\(cell.childCount)"
            childCountArray.removeLast()
        }else {
            showToast(message: "")
        }
        print(childCountArray.count)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        if cell.key == "done" {
            print("btnAction-- adultsCount--   \(totaladultsCount)")
            print("btnAction-- childCount--   \(totalchildCount)")
            print("btnAction-- room count--   \(roomcount)")
            print("adultsCountArray--   \(adultsCountArray.count)")
            print("childCountArray--   \(childCountArray.count)")
            
            defaults.set(roomcount, forKey: UserDefaultsKeys.roomcount)
            defaults.set(adultsCountArray.count, forKey: UserDefaultsKeys.hoteladultscount)
            defaults.set(childCountArray.count, forKey: UserDefaultsKeys.hotelchildcount)
            
            adultsCountArray.removeAll()
            childCountArray.removeAll()
            
            gotoSearchHotelsVC()
            
        }else {
            print("addroom addroom addroom")
            roomcount = roomcount + 1
            roomCountArray.append(roomcount)
            adultsCountArray.append(1)
            appendTVCells()
            
        }
    }
    
    
    
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
}
