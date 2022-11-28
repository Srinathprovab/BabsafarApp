//
//  SearchFlightResultVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC {
    
    @IBOutlet weak var navHeight: NSLayoutConstraint!
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
    var FlightList :[[J_flight_list]]?
    var flightdetails : Flight_details?
    var kwdPriceArray = [String]()
    var dateArray = [String]()
    
    var RTFlightList :[[RTJ_flight_list]]?
    var MCJflightlist :[MCJ_flight_list]?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNav()
        
        
        
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType == "oneway" {
                //FOR APPENDING operator_image AND totalPrice
                FlightList.map { i in
                    i.map { j in
                        j.map { k in
                            k.flight_details?.summary.map({ l in
                                kwdPriceArray.append(k.totalPrice_API ?? "")
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.origin?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        let resultString = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                    }
                                    
                                }
                            })
                        }
                    }
                }
            }else if selectedJourneyType == "circle" {
                
                //FOR APPENDING operator_image AND totalPrice
                RTFlightList.map { i in
                    i.map { j in
                        j.map { k in
                            k.flight_details?.summary.map({ l in
                                kwdPriceArray.append(k.totalPrice_API ?? "")
                                
                                l.map { m in
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd MMM yyyy"
                                    if let date = dateFormatter.date(from: "\(m.destination?.date ?? "")"){
                                        dateFormatter.dateFormat = "dd MMM"
                                        let resultString = dateFormatter.string(from: date)
                                        dateArray.append(dateFormatter.string(from: date))
                                        
                                    }
                                    
                                }
                            })
                        }
                    }
                }
            }else {
                
            }
            
            kwdPriceArray = kwdPriceArray.unique()
            dateArray = dateArray.unique()
            
            
            print(dateArray)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        setupCV()
    }
    
    
    func setUpNav(){
        navView.titlelbl.text = ""
        
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                navView.lbl1.text = "\(defaults.string(forKey: UserDefaultsKeys.fairportCode) ?? "") -> \(defaults.string(forKey: UserDefaultsKeys.tairportCode) ?? "")"
                navView.lbl2.text = "On \(defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")"
                
            }else if journeyType == "circle"{
                
                navView.lbl1.text = "\(defaults.string(forKey: UserDefaultsKeys.rfairportCode) ?? "") <-> \(defaults.string(forKey: UserDefaultsKeys.rtairportCode) ?? "")"
                navView.lbl2.text = "On \(defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "") - Return \(defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "")"
                
            }else {
                
                navView.lbl1.text = "\(defaults.string(forKey: UserDefaultsKeys.mfromairportCode) ?? "") <-> \(defaults.string(forKey: UserDefaultsKeys.mtoairportCode) ?? "")"
                navView.lbl2.text = "On \(defaults.string(forKey: UserDefaultsKeys.mcalDepDate) ?? "")"
            }
        }
        
        navView.editBtnView.isHidden = false
        navView.filterBtnView.isHidden = false
        navView.lbl1.isHidden = false
        navView.lbl2.isHidden = false
        navView.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        navView.filterBtn.addTarget(self, action: #selector(didTapOnFilterBtn(_:)), for: .touchUpInside)
        navView.editBtn.addTarget(self, action: #selector(didTapOnEditBtn(_:)), for: .touchUpInside)
    }
    
    
    
    func setupTV() {
        
        
        cvHolderView.addBottomBorderWithColor(color: .AppBorderColor, width: 0.5)
        baggageBtn.setTitle("", for: .normal)
        
        self.commonTableView.registerTVCells(["SearchFlightResultTVCell","EmptyTVCell","RoundTripFlightResultTVCell","FlightDetailsTVCell","MultiCityTripFlightResultTVCell"])
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedTab == "oneway" {
                setupOneWayResultTVCells()
            }else if selectedTab == "circle" {
                setupRoundTripResultTVCells()
            }else {
                setupMulticityTripResultTVCells()
            }
        }
        
    }
    
    // MARK:- ONE WAY
    func setupOneWayResultTVCells() {
        tablerow.removeAll()
        
        
        FlightList.map { i in
            i.map { j in
                j.map { k in
                    k.flight_details?.summary.map({ l in
                        l.map { m in
                            tablerow.append(TableRow(
                                title:"\(m.operator_name ?? "") (\(m.operator_code ?? ""))",
                                subTitle: k.totalPrice_API,
                                key:"oneway",
                                text: m.origin?.time,
                                headerText: m.destination?.time,
                                buttonTitle: "\(m.destination?.city ?? "") (\(m.destination?.loc ?? ""))",
                                image: m.operator_image,
                                tempText:"\(m.origin?.city ?? "") (\(m.origin?.loc ?? ""))",
                                questionType:m.duration,
                                TotalQuestions: k.selectedResult,
                                cellType:.SearchFlightResultTVCell,
                                questionBase: "no of stops \(String(m.no_of_stops ?? 0))"
                                
                            ))
                        }
                    })
                }
            }
        }
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    // MARK:- ROUND TRIP
    func setupRoundTripResultTVCells() {
        
        tablerow.removeAll()
        
        RTFlightList?.forEach({ i in
            i.forEach { k in
                tablerow.append(TableRow(title:k.totalPrice_API,
                                         headerText:k.totalPrice_API,
                                         errormsg:String(k.flight_details?.summary?.first?.no_of_stops ?? 0),
                                         // isOptional: i.refundable ?? false,
                                         moreData:k.flight_details,
                                         questionType:k.aPICurrencyType,
                                         TotalQuestions: k.selectedResult,
                                         cellType:.RoundTripFlightResultTVCell,
                                         questionBase: k.taxes))
            }
        })
        
        
        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    // MARK:- MULTICITY TRIP
    func setupMulticityTripResultTVCells() {
        tablerow.removeAll()
        
        //        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(title:"",characterLimit: 4,cellType:.MultiCityTripFlightResultTVCell))
        
        
        MCJflightlist?.forEach({ k in
            tablerow.append(TableRow(title:k.totalPrice_API,
                                 //    subTitle:k.booking_source,
                                     headerText:k.totalPrice,
                                     //  errormsg:String(k.mc0.?.flight_details?.summary?.first?.seatsRemaining ?? "0"),
                                     // isOptional: k.refundable ?? "",
                                     moreData:k.mc0?.flight_details,
                                     questionType:k.aPICurrencyType,
                                     TotalQuestions: k.selectedResult,
                                     cellType:.MultiCityTripFlightResultTVCell,
                                     questionBase: k.taxes))
        })
        
        
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
    
    
    
    
    @IBAction func didTapOnBaggageBtn(_ sender: Any) {
        print("didTapOnBaggageBtn")
    }
    
    
    
    override func gotoRoundTripBaggageIntoVC(cell: RoundTripFlightResultTVCell) {
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    
    func gotoBaggageInfoVC() {
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.flightdetails = self.flightdetails
        present(vc, animated: true)
    }
    
    
    override func gotoRoundTripBaggageIntoVC(cell: MultiCityTripFlightResultTVCell) {
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoBaggageInfoVC()
    }
    
    
    
    
}


extension SearchFlightResultVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kwdPriceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BaggageDateCVCell {
            cell.titlelbl.text = "26 july"
            cell.subTitlelbl.text = "\(kwdPriceArray[indexPath.row])"
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
        
        FlightList.map { i in
            i.map { j in
                flightdetails = j[0].flight_details
            }
        }
        
        print(flightdetails)
        
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultTVCell {
            defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
            gotoBaggageInfoVC()
        }
        
        
    }
    
    
    
}


