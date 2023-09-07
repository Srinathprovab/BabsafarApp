//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit
import GoogleMaps

class MapViewVC: UIViewController, CLLocationManagerDelegate {
    
    
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
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupUI() {
        
        self.googleMapView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Map View"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
        
        
    }
    
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Optionally, you can center the map on the user's location
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: 12.0)
            let gmsView = GMSMapView.map(withFrame: view.bounds, camera: camera)
            googleMapView.addSubview(gmsView)
            addMarkersToMap(gmsView)
            
            locationManager.stopUpdatingLocation() // You may want to stop updates after you have the user's location
        }
    }
    
    func addMarkersToMap(_ mapView: GMSMapView) {
        
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
                
                marker.map = mapView
            }
        }
    }
    
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}



