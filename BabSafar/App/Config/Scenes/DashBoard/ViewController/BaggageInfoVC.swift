//
//  BaggageInfoVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class BaggageInfoVC: BaseTableVC {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var itineraryView: UIView!
    @IBOutlet weak var itinerarylbl: UILabel!
    @IBOutlet weak var itineraryBtn: UIButton!
    @IBOutlet weak var fareRulesView: UIView!
    @IBOutlet weak var fareRuleslbl: UILabel!
    @IBOutlet weak var fareRulesBtn: UIButton!
    @IBOutlet weak var baggageInfoView: UIView!
    @IBOutlet weak var baggageInfolbl: UILabel!
    @IBOutlet weak var baggageInfoBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    static var newInstance: BaggageInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BaggageInfoVC
        return vc
    }
    
    var tablerow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupItineraryTVCell()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupViews(v: holderView, radius: 8, color: .WhiteColor)
        setupViews(v: buttonsView, radius: 0, color: .WhiteColor)
        
        setupViews(v: itineraryView, radius: 25, color: .AppTabSelectColor)
        setupViews(v: baggageInfoView, radius: 25, color: .WhiteColor)
        setupViews(v: fareRulesView, radius: 25, color: .WhiteColor)
        
        
        setupLabels(lbl: itinerarylbl, text: "Itinerary", textcolor: .WhiteColor, font: .LatoMedium(size: 14))
        setupLabels(lbl: fareRuleslbl, text: "Fare Rules", textcolor: .AppLabelColor, font: .LatoMedium(size: 14))
        setupLabels(lbl: baggageInfolbl, text: "Baggage Info", textcolor: .AppLabelColor, font: .LatoMedium(size: 14))
        
        closeBtn.setTitle("", for: .normal)
        itineraryBtn.setTitle("", for: .normal)
        fareRulesBtn.setTitle("", for: .normal)
        baggageInfoBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["ItineraryTVCell","FareRulesTVCell","BaggageInfoTVCell","BookNowButtonsTVCell","EmptyTVCell"])
    }
    
    
    func setupItineraryTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.ItineraryTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupFareRulesTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.FareRulesTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func setupBaggageInfoTVCell() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
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
    
    
    @IBAction func didTapOnitIneraryBtn(_ sender: Any) {
        itinerarylbl.textColor = .WhiteColor
        itineraryView.backgroundColor = .AppTabSelectColor
        fareRuleslbl.textColor = .AppLabelColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageInfolbl.textColor = .AppLabelColor
        baggageInfoView.backgroundColor = .WhiteColor
        setupItineraryTVCell()
    }
    
    
    @IBAction func didTapOnitFareRulesBtn(_ sender: Any) {
        
        itinerarylbl.textColor = .AppLabelColor
        itineraryView.backgroundColor = .WhiteColor
        fareRuleslbl.textColor = .WhiteColor
        fareRulesView.backgroundColor = .AppTabSelectColor
        baggageInfolbl.textColor = .AppLabelColor
        baggageInfoView.backgroundColor = .WhiteColor
        setupFareRulesTVCell()
    }
    
    @IBAction func didTapOnitBaggageInfoBtn(_ sender: Any) {
        
        itinerarylbl.textColor = .AppLabelColor
        itineraryView.backgroundColor = .WhiteColor
        fareRuleslbl.textColor = .AppLabelColor
        fareRulesView.backgroundColor = .WhiteColor
        baggageInfolbl.textColor = .WhiteColor
        baggageInfoView.backgroundColor = .AppTabSelectColor
        setupBaggageInfoTVCell()
    }
    
    
    @IBAction func didTapOnitCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func didTapOnKWDBtn(_ sender: UIButton) {
        print("didTapOnKWDBtn")
    }
    
    @objc func didTapOnBookNowBtn(_ sender: UIButton) {
        guard let vc = TravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
}


extension BaggageInfoVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("BookNowButtonsTVCell", owner: self, options: nil)?.first as! BookNowButtonsTVCell
        myFooter.kwdBtn.addTarget(self, action: #selector(didTapOnKWDBtn(_:)), for: .touchUpInside)
        myFooter.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}
