//
//  ViewController.swift
//  Where Am I?
//
//  Created by madhav sharma on 7/16/20.
//  Copyright © 2020 madhav sharma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapViewBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeMapBtn: UIButton!
    
    @IBAction func mapBtnPressed(_ sender: Any) {
        mapView.isHidden = false
        closeMapBtn.isHidden = false
        mapView.updateFocusIfNeeded()
        centerViewOnUserLocation()
        manager.startUpdatingLocation()
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        mapView.isHidden = true
        closeMapBtn.isHidden = true
    }
    
    var manager = CLLocationManager()
    let regionInMeters: Double = 150000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitudeLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        latitudeLabel.layer.borderWidth = 1.0
        latitudeLabel.layer.cornerRadius = 5.0
        latitudeLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2538794949)
        
        longitudeLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        longitudeLabel.layer.borderWidth = 1.0
        longitudeLabel.layer.cornerRadius = 5.0
        longitudeLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.251364512)
        
        courseLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        courseLabel.layer.borderWidth = 1.0
        courseLabel.layer.cornerRadius = 5.0
        courseLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2520601455)
        
        speedLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        speedLabel.layer.borderWidth = 1.0
        speedLabel.layer.cornerRadius = 5.0
        speedLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2451038099)
        
        altitudeLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        altitudeLabel.layer.borderWidth = 1.0
        altitudeLabel.layer.cornerRadius = 5.0
        altitudeLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2523544521)
        
        addressLabel.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addressLabel.layer.borderWidth = 1.0
        addressLabel.layer.cornerRadius = 5.0
        addressLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1996735873)
        
        mapView.showsUserLocation = true
        mapView.updateFocusIfNeeded()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        mapView.updateFocusIfNeeded()
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        self.latitudeLabel.text = String(location.coordinate.latitude)
        self.longitudeLabel.text = String(location.coordinate.longitude)
        self.courseLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\n"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\n"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country!
                        
                    }
                    
                    self.addressLabel.text = address
                    
                }
            }
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = manager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

