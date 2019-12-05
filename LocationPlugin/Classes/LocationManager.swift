//
//  LocationManager.swift
//  HQPAlamofire
//
//  Created by 9tong on 2019/12/4.
//  Copyright © 2019 hqp. All rights reserved.
//

import Foundation
import CoreLocation


public class LocationManager {
    public static let `default`: LocationManager = {
        let location = LocationManager()
        return location
      }()
    
    
    public var defaultDistanceFilter = 10.0
    
    var location: CLLocationManager
    var delegate: LocationDelegate
    
    init() {
        location = CLLocationManager()
        location.identify = UUID().uuidString
        location.distanceFilter = defaultDistanceFilter
        location.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.delegate = LocationDelegate()
        location.delegate = self.delegate
        
       
    }
    
    // 开始定位
    public func requestLocation()-> LocationRequest{
    
        let result = LocationRequest()
        if #available(iOS 8.0, *) {
            self.location.requestWhenInUseAuthorization()
        }
        self.location.startUpdatingLocation()

        delegate[location] = result
        
        return result
    }
    
}


extension CLLocationManager {
    
    private struct AssocaitedKeys {
        static var identifier = "identifier"
    }
    
    // 唯一标识
    var identify: String {
        get {
            return objc_getAssociatedObject(self, &AssocaitedKeys.identifier) as? String ?? ""
        }
        
        set {
            objc_setAssociatedObject(self, &AssocaitedKeys.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
