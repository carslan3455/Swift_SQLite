import SwiftUI
import CoreMotion

// ==================================================================

struct DeviceRotationViewModifier: ViewModifier
{
    let action: (UIDeviceOrientation) -> Void
    
    func body (content: Content) -> some View
    {
        content
            .onAppear()
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIDevice.orientationDidChangeNotification))
        {
            _ in action(UIDevice.current.orientation)
        }
    }
}

// ==================================================================

extension View
{
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View
    {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

// ==================================================================

struct SensorView: View
{
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var motion = ""
    
    var body: some View
    {
        VStack
        {
            Text("Motion: \(motion)")
           
            Group
            {
                if (orientation.isPortrait)
                {
                    Text("Orientation: Portrait")
                }
                else if (orientation.isLandscape)
                {
                    Text("Orientation: Landscape")
                }
                else if (orientation.isFlat)
                {
                    Text("Orientation: Flat")
                }
                else
                {
                    Text("Orientation: Unknown")
                }
            }
        }.onRotate
        {
            newOrientation in orientation = newOrientation
        }
        .onAppear(perform: messen)
    }
    
    func messen()
    {
        let motionmanager = CMMotionManager()
        
        motionmanager.startAccelerometerUpdates(to: OperationQueue.main)
        {
            (data, error) in
            if let acc = data?.acceleration
            {
                motion = "(x, y, z) = (\(acc.x), \(acc.y), \(acc.z))"
            }
        }
    }
}

// ==================================================================

struct SensorView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SensorView()
    }
}
