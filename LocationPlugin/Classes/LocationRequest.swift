//
//  LocationRequest.swift
//  HQPAlamofire
//
//  Created by 9tong on 2019/12/4.
//  Copyright © 2019 hqp. All rights reserved.
//

import Foundation
import CoreLocation


public class LocationRequest {
    var queue: OperationQueue!
    var error: Error?
    
    var locationResult: CLLocationCoordinate2D?
    
    public typealias coordinateHandler = ((LocationResponse) -> Void)?
    public typealias reverseGeocodeHandler = ((ReverseGeocodeResponse?) -> Void)?
    
    var locationUpdateHandler : coordinateHandler
    var reverseGeocodeHandler : reverseGeocodeHandler
    
    init() {
       self.queue = {
           let operationQueue = OperationQueue()

           operationQueue.maxConcurrentOperationCount = 1
           operationQueue.isSuspended = true
           operationQueue.qualityOfService = .utility

           return operationQueue
       }()
    }

    //MARK: -- 定位位置
    @discardableResult
    public func responseResult(completeHandler:((LocationResponse) -> Void)?) -> Self {
        self.queue.addOperation {
            let corninate = self.locationResult
            if let handler = completeHandler {
                let response = LocationResponse(
                    coordinate: corninate,
                    error: self.error
                )
                handler(response)
            }
        }
        return self
    }
    
    //MARK: -- 反编码结果
    @discardableResult
    public func reverseGeocodeLocationResult(completeHandler: reverseGeocodeHandler) -> Self {
        
        self.reverseGeocodeHandler = completeHandler
        return self
    }
    
    //MARK: -- 地理位置改变
    @discardableResult
    public func didUpdateResult( completeHandler: coordinateHandler)  -> Self {

        self.locationUpdateHandler = completeHandler
        return self
    }
}


public class LocationResponse {
    public var coordinate: CLLocationCoordinate2D?
    public var error : Error?
    
    public init(coordinate: CLLocationCoordinate2D?, error: Error?) {
        self.coordinate = coordinate
        self.error = error
    }
}

public class ReverseGeocodeResponse {

   public var country: String?
   public var isoCountryCode: String?
   public var administrativeArea: String?
   public var subAdministrativeArea: String?
   public var thoroughfare: String?
    
   public init(country: String?,
         isoCountryCode: String?,
         administrativeArea: String?,
         subAdministrativeArea: String?,
         thoroughfare: String?) {
        self.country = country
        self.isoCountryCode = isoCountryCode
        self.administrativeArea = administrativeArea
        self.subAdministrativeArea = subAdministrativeArea
        self.thoroughfare = thoroughfare
    }
    
}
