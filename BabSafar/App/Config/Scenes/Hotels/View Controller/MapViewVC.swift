//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit
import GoogleMaps

class MapViewVC: UIViewController {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
        return vc
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setupUI()
        
        
        
    }
    
    func setupUI() {
        
        self.googleMapView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Map View"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
        let googleMapView1 = GMSMapView(frame: view.bounds)
        googleMapView.addSubview(googleMapView1)
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        marker.title = "San Francisco"
        marker.snippet = "California, USA"
        marker.map = googleMapView1
        
        
    }
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}



