//
//  AddressTools.swift
//  CustomToolsDGP
//
//  Created by David SG on 03/06/2020.
//  Copyright © 2020 David Galán. All rights reserved.
//


#if canImport(UIKit)
import UIKit
#endif
import MapKit


extension String {
    
    public func openAddress(typeAddressResult: AddressTools.TypeAddressResult, completion: @escaping (Bool) -> ()) {

        AddressTools().openAddressActions(address: self, typeAddressResult: typeAddressResult) { (success) in
            
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}



public class AddressTools {

    public enum TypeAddressResult {
        case address
        case location
    }
    
    public init() {
        
    }
    
    
    func openAddressActions(address: String, typeAddressResult: TypeAddressResult, completion: @escaping (Bool) -> ()) {
                
        switch typeAddressResult {

        case .address:
            
            guard let address = URL(string: "http://maps.apple.com/?address=\(address)") else {
                completion(false)
                return
            }
            #if canImport(UIKit)
            UIApplication.shared.open(address)
            #endif
            completion(true)
            
            break
            
        case .location:
            
            self.coordinates(forAddress: address, completion: { (location) in
                
                if location != nil {
                    let query = "?ll=\(location!.latitude),\(location!.longitude)"
                    let path = "http://maps.apple.com/" + query
                    if let url = URL(string: path) {
                        #if canImport(UIKit)
                        UIApplication.shared.open(url)
                        #endif
                        completion(true)
                        
                    } else {
                        // Could not construct url. Handle error.
                        print("nop2")
                        completion(false)
                    }
                } else {
                    print("nop1")
                    completion(false)
                }
                
            })
            
            break
        }
    }
    
    
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    
}
