//
//  LocationViewModel.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/25/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import Foundation
//import Combine
import CoreLocation

class LocationViewModel: NSObject, ObservableObject{
  
    @Published var datas : [datatype] = []
    
  //@Published var userLatitude: Double = 0
  //@Published var userLongitude: Double = 0
    var userLatitude: Double = 0 {
        didSet {
            print("Latitude: \(userLatitude)")
          print("Longitude: \(userLongitude)")
          
          let url1 = "https://developers.zomato.com/api/v2.1/geocode?lat=\(userLatitude)&lon=\(userLongitude)"
          let api = "64d2d705881152ccb8e4cfa15f6dc722"
          
          let url = URL(string: url1)
          var request = URLRequest(url: url!)
      
          request.addValue("application/json", forHTTPHeaderField: "Accept")
          request.addValue(api, forHTTPHeaderField: "user-key")
          request.httpMethod = "GET"
          
          let sess = URLSession(configuration: .default)
          sess.dataTask(with: request) { (data, _, _) in
              
              do{
                  
                  let fetch = try JSONDecoder().decode(Type.self, from: data!)
                  print(fetch)
                var data = [datatype]()
                  for i in fetch.nearby_restaurants{
                      
                      data.append(datatype(id: i.restaurant.id, name: i.restaurant.name, image: i.restaurant.thumb, //rating: //i.restaurant.user_rating.aggregate_rating,//
                      webUrl: i.restaurant.url))

                  }
                
                DispatchQueue.main.async {
                    self.datas = data
                }
                
              }
              catch{
                  
                  print(error)
                  
              }
              
          }.resume()
        }
    }
    var userLongitude: Double  = 0
    
    
  
  private let locationManager = CLLocationManager()
//  let objectWillChange = PassthroughSubject<Void, Never>()
//   private let geocoder = CLGeocoder()
//
//   @Published var status: CLAuthorizationStatus? {
//     willSet { objectWillChange.send() }
//   }
//    @Published var placemark: CLPlacemark? {
//      willSet { objectWillChange.send() }
//    }
//   @Published var location: CLLocation? {
//     willSet { objectWillChange.send() }
//   }
//    private func geocode() {
//      guard let location = self.location else { return }
//      geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
//        if error == nil {
//          self.placemark = places?[0]
//        } else {
//          self.placemark = nil
//        }
//      })
//    }
  override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
}

extension LocationViewModel: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    userLongitude = location.coordinate.longitude
    userLatitude = location.coordinate.latitude
    print(location)
    self.locationManager.stopUpdatingLocation()
    
  }
}
