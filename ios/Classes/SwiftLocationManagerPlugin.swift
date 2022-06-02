import Flutter
import UIKit
import CoreLocation

public class SwiftLocationManagerPlugin: NSObject, FlutterPlugin,FlutterStreamHandler, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager = .init()
    var eventSink: FlutterEventSink?
    
    private func configureLocation() -> Bool {
        // Ask for Authorization from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
              locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
              locationManager.distanceFilter = kCLDistanceFilterNone
              locationManager.allowsBackgroundLocationUpdates = true
              locationManager.pausesLocationUpdatesAutomatically = false
              locationManager.startUpdatingLocation()
              startMySignificantLocationChanges()
              locationManager.delegate = self
            return true
        }
        return false
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let eventChannel = FlutterEventChannel(name: "location_manager/event_channel", binaryMessenger: registrar.messenger())
      
    let instance = SwiftLocationManagerPlugin()
    eventChannel.setStreamHandler(instance)
  }
    // Entry point for the stream subscription, pushing location events to the stream sink
   public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
       print(arguments!)
       if(configureLocation()){
           self.eventSink = events
  
           guard let location = locationManager.location else {
               return FlutterError(code: "ERROR", message: "Unable to get location", details: nil)
           }
          
           var accuracy:CLLocationDirectionAccuracy?
           if #available(iOS 13.4, *) {
               accuracy =  location.courseAccuracy
           } else {
               // course accuracy not available
           }
           let speed = location.speed
           let altitude = location.altitude
           let locationCoordinates = location.coordinate
           
           updateLocation(locationCoordinates: locationCoordinates,
           accuracy: accuracy, speed: speed, altitude: altitude
           )
           return nil
       }
       return FlutterError(code: "ERROR", message: "Location services are not enabled", details: nil)
    }
    /*
    Disposal of the stream sink resources
    */
   public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        debugPrint("On Cancel Event Sink")
        eventSink = nil
        return nil
    }
    
    private func updateLocation(locationCoordinates: CLLocationCoordinate2D,
                                accuracy: CLLocationDirectionAccuracy?,
                                speed: CLLocationSpeed,
                                altitude: CLLocationDistance){
    
        let data: [String: Any] = ["latitude": locationCoordinates.latitude,
                                   "longitude": locationCoordinates.longitude,
                                   "altitude": altitude,
                                   "speed": speed,
                                   "accuracy": accuracy ?? 0.0,
        ]
        
        guard let eventSink = self.eventSink else {
             return
           }
        eventSink(data)
    }
    
   private func startMySignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The device does not support this service.
            return
        }
        locationManager.startMonitoringSignificantLocationChanges()
    }
   public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
       if let location = locations.last {
           var accuracy:CLLocationDirectionAccuracy?
           if #available(iOS 13.4, *) {
               accuracy =  location.courseAccuracy
           } else {
               // course accuracy not available
           }
           let speed = location.speed
           let altitude = location.altitude
           let locationCoordinates: CLLocationCoordinate2D = location.coordinate
           
           updateLocation(locationCoordinates: locationCoordinates,
           accuracy: accuracy, speed: speed, altitude: altitude
           )
           
           if(UIApplication.shared.applicationState == .background){
               print("The app is in the background")
           }
           else if(UIApplication.shared.applicationState == .active){
               print("The app is in the forground")
           }
           else if(UIApplication.shared.applicationState == .inactive){
               print("The app is inactive")
           }
       }
       else {
           print("Unable to get location")
       }
    }
    
   public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
       // Notify the user of any errors.
    }

    public func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
    // Do something with the visit.
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            print("did exit region")

            locationManager.stopMonitoring(for: region)

            //Start location manager and get current location
            locationManager.startUpdatingLocation()
        }
    
    public  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
       print("did enter region")
       if let region = region as? CLCircularRegion {
          let identifier = region.identifier
          print(identifier)
          //triggerTaskAssociatedWithRegionIdentifier(regionID: identifier)
    }
   }
   public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
               if status == .authorizedAlways {
                   // you're good to go!
               }
           }
    
    
    func monitorRegionAtLocation(center: CLLocationCoordinate2D, radius: Double?, identifier: String ) {
        // Make sure the devices supports region monitoring.
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            // Register the region.
            let maxDistance = locationManager.maximumRegionMonitoringDistance
            let region = CLCircularRegion(center: center,
                 radius: radius ?? maxDistance, identifier: identifier)
            region.notifyOnEntry = true
            region.notifyOnExit = true
       
            //Stop your location manager for updating location and start region Monitoring
            locationManager.stopUpdatingLocation()
            locationManager.startMonitoring(for: region)
            
        }else{
            print("No support for tracking regions")
        }
    }

}




   

