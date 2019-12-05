//
//  LocationDelegate.swift
//  HQPAlamofire
//
//  Created by 9tong on 2019/12/2.
//  Copyright © 2019 hqp. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationDelegate: NSObject {
    
    public var didUpateLocations: ((CLLocationManager, [CLLocation]) -> Void)?
    private var geocoder = CLGeocoder()
    private var requests: [String: LocationRequest] = [:]
    private let lock = NSLock()
    open subscript (locationManager : CLLocationManager) -> LocationRequest? {
        get {
            lock.lock(); defer {lock.unlock() }
            return requests[locationManager.identify] 
        }
        
        set {
            lock.lock(); defer {lock.unlock()}
            requests[locationManager.identify] = newValue
        }
    }
    
}


extension LocationDelegate :CLLocationManagerDelegate {
  
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mlocation = locations.last
        guard let location = mlocation else {
            return
        }

        if let request = self[manager] {
            request.locationResult = location.coordinate
            request.error = nil
            request.queue.isSuspended = false
            
            if let reverseGeoCodeHandler = request.reverseGeocodeHandler {
                self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    let placemark = placemarks?.first
                    let reverseGeocodeResponse = ReverseGeocodeResponse(country: placemark?.country,
                                                                        isoCountryCode: placemark?.isoCountryCode,
                                                                        administrativeArea: placemark?.administrativeArea,
                                                                        subAdministrativeArea: placemark?.subAdministrativeArea,
                                                                        thoroughfare: placemark?.thoroughfare)
                    //地理位置反编码
                    reverseGeoCodeHandler(reverseGeocodeResponse)
                }
            }
    
           
            // 定位位置改变
            if let updateHandler = request.locationUpdateHandler {
                let response =  LocationResponse(coordinate: location.coordinate, error: nil)
                updateHandler(response)
            }
        }
    }

    // 定位失败
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let request = self[manager] {
            request.locationResult = nil
            request.error = error
            request.queue.isSuspended = false
            
            if let handler = request.locationUpdateHandler {
                let response = LocationResponse(coordinate: nil, error: error)
                handler(response)
            }
        }
        
       
        
    }
    
}
