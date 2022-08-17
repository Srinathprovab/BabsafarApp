//
//  SearchFlightResultVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC {
    
    
    @IBOutlet weak var navView: NavBar!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var baggageBtn: UIButton!
    @IBOutlet weak var baggageDateCV: UICollectionView!
    
    
    
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        setupCV()
    }
    
    
    
    func setupTV() {
        
        navView.titlelbl.text = ""
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.filterBtn.addTarget(self, action: #selector(didTapOnFilterBtn(_:)), for: .touchUpInside)
        navView.editBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
        navView.lbl1.text = "dubai (DXB) - kuwait (kWI)"
        navView.lbl2.text = "26 jul - 27 jul | 26 jul - 27 jul"
        navView.editBtnView.isHidden = false
        navView.filterBtnView.isHidden = false
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        cvHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 0.5)
        baggageBtn.setTitle("", for: .normal)
        
        self.commonTableView.registerTVCells(["SearchFlightResultTVCell","EmptyTVCell","RoundTripFlightResultTVCell","FlightDetailsTVCell","MultiCityTripFlightResultTVCell"])
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupOneWayResultTVCells()
            }else if selectedTab == "roundtrip" {
                setupRoundTripResultTVCells()
            }else {
                setupMulticityTripResultTVCells()
            }
        }
        
    }
    
    // MARK:- ONE WAY
    func setupOneWayResultTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(cellType:.SearchFlightResultTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    // MARK:- ROUND TRIP
    func setupRoundTripResultTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 2,cellType:.RoundTripFlightResultTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 2,cellType:.RoundTripFlightResultTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 2,cellType:.RoundTripFlightResultTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 2,cellType:.RoundTripFlightResultTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 2,cellType:.RoundTripFlightResultTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    // MARK:- MULTICITY TRIP
    func setupMulticityTripResultTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"",characterLimit: 4,cellType:.MultiCityTripFlightResultTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupCV() {
        let nib = UINib(nibName: "BaggageDateCVCell", bundle: nil)
        baggageDateCV.register(nib, forCellWithReuseIdentifier: "cell")
        baggageDateCV.delegate = self
        baggageDateCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        baggageDateCV.collectionViewLayout = layout
        baggageDateCV.backgroundColor = .clear
        baggageDateCV.layer.cornerRadius = 4
        baggageDateCV.clipsToBounds = true
        baggageDateCV.showsHorizontalScrollIndicator = false
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton){
        dismiss(animated: true)
    }
    
    @objc func didTapOnFilterBtn(_ sender:UIButton){
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func didTapOnEditBtn(_ sender:UIButton){
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    func gotoBaggageInfoVC() {
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @IBAction func didTapOnBaggageBtn(_ sender: Any) {
        print("didTapOnBaggageBtn")
    }
    
    
    
    override func gotoRoundTripBaggageIntoVC(cell: RoundTripFlightResultTVCell) {
        gotoBaggageInfoVC()
    }
    
    
    override func gotoRoundTripBaggageIntoVC(cell: MultiCityTripFlightResultTVCell) {
        gotoBaggageInfoVC()
    }
    
    
    
    
}


extension SearchFlightResultVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BaggageDateCVCell {
            cell.titlelbl.text = "26 jul"
            cell.subTitlelbl.text = "kwd: 150.00"
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BaggageDateCVCell {
            cell.holderView.backgroundColor = .AppCalenderDateSelectColor
            cell.titlelbl.textColor = .WhiteColor
            cell.subTitlelbl.textColor = .WhiteColor
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? BaggageDateCVCell {
            cell.holderView.backgroundColor = .WhiteColor
            cell.titlelbl.textColor = HexColor("#808089")
            cell.subTitlelbl.textColor = HexColor("#808089")
        }
    }
    
}


extension SearchFlightResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoBaggageInfoVC()
    }
}
