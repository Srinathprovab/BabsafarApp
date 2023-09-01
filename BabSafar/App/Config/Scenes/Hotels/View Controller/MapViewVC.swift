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
        addMarkersToMap()
        
    }
    
    func setupUI() {
        
        self.googleMapView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Map View"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
        
        
    }
    
    func addMarkersToMap() {
        let gmsView = GMSMapView(frame: view.bounds)
        googleMapView.addSubview(gmsView)
        
        for index in 0..<latArray.count {
            if let latitude = Double(latArray[index]), let longitude = Double(longArray[index]) {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                marker.title = "Location \(index + 1)"
                
                // Create a custom marker icon with an image
                if let markerImage = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.red) {
                    let markerView = UIImageView(image: markerImage)
                    marker.iconView = markerView
                }
                
                marker.map = gmsView
            }
        }
    }

    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}



