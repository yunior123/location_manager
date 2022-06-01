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
       if( configureLocation()){
           self.eventSink = events
           updateLocation()
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
    
    private func updateLocation(){
        guard let locationCoordinates: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
    
        let data: [String: Any] = ["latitude": locationCoordinates.latitude, "longitude": locationCoordinates.longitude,]
        
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
       updateLocation()
    }
    
   public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
       // Notify the user of any errors.
    }

}




   

