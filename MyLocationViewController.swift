
import UIKit
import CoreLocation

class MyLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var laLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager:CLLocationManager!
    
    var location: CLLocation!{
        didSet{
            laLabel.text = "\(location.coordinate.latitude)"
            longLabel.text = "\(location.coordinate.longitude)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
    }
    
    func checkCoreLocationPermission(){
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .Restricted{
            //put an alertView (later)
            print("Unauthorize to use location service.")
        }
        
    }
    
    @IBAction func getLocation(sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = (locations ).last
        locationManager.stopUpdatingLocation()  // save battery
    }
    
    //ทำให้หน้าจอแอพเป็นแนวตั้งอย่างเดียว
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
}