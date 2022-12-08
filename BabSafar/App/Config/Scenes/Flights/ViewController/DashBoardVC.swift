//
//  DashBoardVC.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class DashBoardVC: BaseTableVC, TopFlightDetailsViewModelDelegate {
    
    
    @IBOutlet weak var banerImage: UIImageView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var banerView: UIView!
    @IBOutlet weak var selectLangView: UIView!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var langLeftImage: UIImageView!
    @IBOutlet weak var langDropdownImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tabSelectionView: UIView!
    @IBOutlet weak var tabSelectCV: UICollectionView!
    
    
    
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    //MARK: Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    
    
    
    //MARK: - LOCAL VARIABLES
    var tabNames = ["Flights","Hotels","Visa"]
    var tabNamesImages = ["flight","hotel","visa"]
    var tableRow = [TableRow]()
    var viewmodel:TopFlightDetailsViewModel?
    
    
    
    //MARK: - LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.gotoPrivacyScreen()
            }
            defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(0, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            tabSelectCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set(0, forKey: UserDefaultsKeys.journeyTypeSelectedIndex)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("English", forKey: UserDefaultsKeys.APILanguageType)
            langLabel.text = "EN"
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            switch tabselect {
                
            case "Flights":
                DispatchQueue.main.async {[self] in
                    callTopFlightsHotelsDetailsAPI()
                }
                break
                
                
            default:
                break
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: Notification.Name("reload"), object: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupCV()
        setupUI()
        viewmodel = TopFlightDetailsViewModel(self)
    }
    
    
    
    //MARK: - VIEW SETUP
    func setupUI() {
        
        
        holderView.backgroundColor = .WhiteColor
        banerImage.image = UIImage(named: "baner")
        banerImage.contentMode = .scaleAspectFill
        selectLangView.backgroundColor = .clear
        tabSelectionView.addCornerRadiusWithShadow(color: .clear , borderColor: .clear, cornerRadius: 6)
        tabSelectionView.backgroundColor = .WhiteColor.withAlphaComponent(0.5)
        tabSelectCV.backgroundColor = .clear
        langLeftImage.image = UIImage(named: "lang")
        langDropdownImage.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        setuplabels(lbl: langLabel, text: defaults.string(forKey: UserDefaultsKeys.APILanguageType) ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 14), align: .center)
        setuplabels(lbl: titleLabel, text: "Please select a service .", textcolor: .WhiteColor, font: .LatoRegular(size: 22), align: .left)
        
        setupMenu()
        
        //MARK: REGISTER TABEL VIEW CELLS
        self.commonTableView.registerTVCells(["SpecialDealsTVCell","TopCityTVCell","EmptyTVCell"])
        
        
    }
    
    
    
    
    
    
    //MARK: - RELOAD TABLE VIEW
    @objc func reload(notification: Notification) {
        commonTableView.reloadData()
    }
    
    
    //MARK: CALL TOP FLIGHT HOTEL DETAILS API FUNCTION
    func callTopFlightsHotelsDetailsAPI() {
        BASE_URL = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/general/"
        viewmodel?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }
    
    //MARK: CALL TOP FLIGHT DETAILS IMAGES API FUNCTION
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        print(" ======= topFlightDetailsImages ======== ")
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        
    }
    
    
    
    
    //MARK: SETUP INITIAL TABLEVIEW CELLS
    func setupTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(cellType:.SpecialDealsTVCell))
        tableRow.append(TableRow(title:"Top International Destinations",key: "flights",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:16,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Top International Hotels",key: "hotels",cellType:.TopCityTVCell))
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    //MARK: SETUP COLLECTION VIEW CELL
    func setupCV() {
        let nib = UINib(nibName: "TabSelectCVCell", bundle: nil)
        tabSelectCV.register(nib, forCellWithReuseIdentifier: "cell")
        tabSelectCV.delegate = self
        tabSelectCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        tabSelectCV.collectionViewLayout = layout
        tabSelectCV.isScrollEnabled = false
    }
    
    
    //MARK: GOTO PRIVACY SETUP SCREEN
    func gotoPrivacyScreen() {
        guard let vc = YourPrivacyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: GOTO SEARCH FLIGHT SCREEN
    func gotoSearchFlightScreen() {
        guard let vc = SearchFlightsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GO TO VISA ENQUIREY SCREEN
    func gotoVisaEnduiryVC() {
        guard let vc = VisaEnduiryVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: GOTO SEARCH HOTEL SCREEN
    func gotoSearchHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    
    
    
    
    @IBAction func selectLangButtonAction(_ sender: Any) {
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        
        
    }
    
    
    //MARK: -  MENU RELATED STUFF
    
    
    //MARK:  Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    @IBAction func menuButtonAction(_ sender: Any) {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}





extension DashBoardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TabSelectCVCell {
            cell.titlelbl.text = tabNames[indexPath.row]
            cell.img.image = UIImage(named: tabNamesImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
            
            if indexPath.row == defaults.integer(forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex) {
                cell.imageStr = tabNamesImages[indexPath.row]
                cell.selected()
                setupTV()
                tabSelectCV.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? TabSelectCVCell {
            defaults.set(tabNames[indexPath.row], forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(indexPath.row, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            cell.imageStr = tabNamesImages[indexPath.row]
            cell.selected()
            
            switch indexPath.row {
            case 0:
                gotoSearchFlightScreen()
                break
                
            case 1:
                gotoSearchHotelsVC()
                break
                
            case 2:
                gotoVisaEnduiryVC()
                break
                
            default:
                break
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabSelectCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 90)
        
    }
    
}



extension DashBoardVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}
