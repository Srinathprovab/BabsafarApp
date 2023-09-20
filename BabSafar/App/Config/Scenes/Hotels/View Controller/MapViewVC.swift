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
        
        print(latArray)
        print(longArray)
        
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
            if !latArray.isEmpty && !longArray.isEmpty {
                // Calculate the average latitude and longitude
                let averageLatitude = latArray.map { Double($0) ?? 0.0 }.reduce(0.0, +) / Double(latArray.count)
                let averageLongitude = longArray.map { Double($0) ?? 0.0 }.reduce(0.0, +) / Double(longArray.count)
                
                // Set the camera to center on the average coordinates
                let camera = GMSCameraPosition.camera(withLatitude: averageLatitude, longitude: averageLongitude, zoom: 10.9)

                let gmsView = GMSMapView.map(withFrame: view.bounds, camera: camera)
                googleMapView.addSubview(gmsView)
                addMarkersToMap(gmsView)
                
                locationManager.stopUpdatingLocation() // You may want to stop updates after you have the user's location
            }
        }
    }

    
    func addMarkersToMap(_ mapView: GMSMapView) {
        for index in 0..<latArray.count {
            if let latitude = Double(latArray[index]), let longitude = Double(longArray[index]) {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            //    marker.title = "Location \(index + 1)"

                // Create a custom marker icon with an image
                if let markerImage = UIImage(named: "customhotel")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor) {
                    let markerView = UIImageView(image: markerImage)
                    marker.iconView = markerView
                } else {
                    print("Error: Marker image not found or is nil.")
                }

                marker.map = mapView
            } else {
                print("Error: Invalid latitude or longitude values at index \(index).")
            }
        }
    }

    
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}



