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
    var kwdPriceArray = [String]()
    var dateArray = [String]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
       
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
                
                MCJflightlist?.forEach({ i in
                    kwdPriceArray.append(i.totalPrice_API ?? "")
                    i.flight_details?.summary?.forEach({ j in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        if let date = dateFormatter.date(from: "\(j.destination?.date ?? "")"){
                            dateFormatter.dateFormat = "dd MMM"
                            let resultString = dateFormatter.string(from: date)
                            dateArray.append(dateFormatter.string(from: date))
                            
                        }
                    })
                })
                
            }
            
            kwdPriceArray = kwdPriceArray.unique()
            dateArray = dateArray.unique()
            
            
            print(dateArray)
        }
        
        
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
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
            navHeight.constant = 200
        }else {
            navHeight.constant = 160
        }
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                
                
                setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport) ?? "") -> \(defaults.string(forKey: UserDefaultsKeys.toairport) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
                
                setuplabels(lbl: navView.lbl2, text: "On \(defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") | \(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
                
            }else if journeyType == "circle"{
                
                
                
                
                
                setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport) ?? "") <-> \(defaults.string(forKey: UserDefaultsKeys.rtoairport) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
                
                setuplabels(lbl: navView.lbl2, text: "On \(defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "") & \(defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "") | \(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
                
                
            }else {
                
                
                
                setuplabels(lbl: navView.lbl1, text: "\(defaults.string(forKey: UserDefaultsKeys.mfromCity) ?? "") <-> \(defaults.string(forKey: UserDefaultsKeys.mtoCity) ?? "")", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
                setuplabels(lbl: navView.lbl2, text: "On \(defaults.string(forKey: UserDefaultsKeys.mcalDepDate) ?? "")", textcolor: .WhiteColor, font: .LatoRegular(size: 12), align: .center)
                
                
                
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
        
        
        FlightList?.forEach({ i in
            i.forEach { j in
                j.flight_details?.summary?.forEach({ k in
                    tablerow.append(TableRow(
                        title:"\(k.operator_name ?? "") (\(k.operator_code ?? ""))",
                        subTitle: j.totalPrice_API,
                        key:"oneway",
                        text: k.origin?.time,
                        headerText: k.destination?.time,
                        buttonTitle: "\(k.destination?.city ?? "") (\(k.destination?.loc ?? ""))",
                        image: k.operator_image,
                        tempText:"\(k.origin?.city ?? "") (\(k.origin?.loc ?? ""))",
                        questionType:k.duration,
                        TotalQuestions: j.selectedResult,
                        cellType:.SearchFlightResultTVCell,
                        questionBase: "no of stops \(String(k.no_of_stops ?? 0))"
                        
                    ))
                })
            }
        })
        
        
        
        
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
        
        MCJflightlist?.forEach({ k in
            tablerow.append(TableRow(title:k.totalPrice_API,
                                     //    subTitle:k.booking_source,
                                     headerText:k.totalPrice,
                                     //  errormsg:String(k.mc0.?.flight_details?.summary?.first?.seatsRemaining ?? "0"),
                                     // isOptional: k.refundable ?? "",
                                     moreData:k.flight_details,
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
        defaults.set(cell.indexPath?.row ?? 0, forKey: UserDefaultsKeys.selectdFlightcellIndex)
        gotoBaggageInfoVC()
    }
    
    override func gotoRoundTripBaggageIntoVC(cell: MultiCityTripFlightResultTVCell) {
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        defaults.set(cell.indexPath?.row ?? 0, forKey: UserDefaultsKeys.selectdFlightcellIndex)
        gotoBaggageInfoVC()
    }
    
    
    func gotoBaggageInfoVC() {
        guard let vc = BaggageInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
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
        
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultTVCell {
            defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
            defaults.set(cell.indexPath?.row ?? 0, forKey: UserDefaultsKeys.selectdFlightcellIndex)
            gotoBaggageInfoVC()
        }
        
        
    }
    
    
    
}


