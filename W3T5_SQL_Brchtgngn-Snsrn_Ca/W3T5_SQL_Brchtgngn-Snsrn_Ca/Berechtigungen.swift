import SwiftUI
import CoreMotion
import AVKit
import CoreLocation

/*
 * Bei Storyboard: Info.plist
 * Bei SwiftUI:
 * Projekt -> Info -> Custom iOS Target Properties
 *   - "Privacy - Camera Usage Description"
 *   - "Privacy - Location when in use usage description"
 */
// Quelle: https://medium.com/@sarimk80/swiftui-permissions-df11a0f4e264
@MainActor
class CameraPermission: ObservableObject
{
    @Published var isCameraPermission:Bool = false
    
    func getCameraPermission() async
    {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch(status)
        {
            case .authorized:
                isCameraPermission = true
            case .notDetermined:
                await AVCaptureDevice.requestAccess(for: .video)
                isCameraPermission = true
            case .denied:
                isCameraPermission = false
            case .restricted:
                isCameraPermission = false
                
            @unknown default:
                isCameraPermission = false
        }
    }
}

class MotionPermission: ObservableObject
{
    @Published var isMotionPermission:Bool = false
    
    func getCameraPermission() async
    {
        let m = CMMotionManager()
    }
}

class LocationPermission:NSObject, ObservableObject, CLLocationManagerDelegate
{
    
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    private let locationManager = CLLocationManager()
    @Published var cordinates : CLLocationCoordinate2D?
    
    override init()
    {
        super.init()
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocationPermission()
    {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager)
    {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else {return}
        
        cordinates = location.coordinate
    }
}

struct BerechtigungView: View
{
    @StateObject private var cameraPermission: CameraPermission = CameraPermission()
    @StateObject private var locationPermission: LocationPermission = LocationPermission()

    var body: some View
    {
        VStack
        {
            Text("Camera Permission \(cameraPermission.isCameraPermission.description)")
           
            switch locationPermission.authorizationStatus
            {
                case .notDetermined:
                    Text("not determined")
                case .restricted:
                    Text("restricted")
                case .denied:
                    Text("denied")
                case .authorizedAlways:
                    VStack {
                        Text(locationPermission.cordinates?.latitude.description ?? "")
                        Text(locationPermission.cordinates?.longitude.description ?? "")
                    }
                case .authorizedWhenInUse:
                    VStack {
                        Text(locationPermission.cordinates?.latitude.description ?? "")
                        Text(locationPermission.cordinates?.longitude.description ?? "")
                    }
                default:
                    Text("no")
                }
                
            
            Button {
                Task{
                    await cameraPermission.getCameraPermission()
                }
            } label: {
                Text("Ask Camera Permission")
                    .padding()
            }
            
            Button {
                locationPermission.requestLocationPermission()
            } label: {
                Text("Ask Location Permission")
                    .padding()
            }
            
        }
        .buttonStyle(.bordered)
        
    }
    
    
}
struct BerechtigungView_Previews: PreviewProvider {
    static var previews: some View {
        BerechtigungView()
    }
}

