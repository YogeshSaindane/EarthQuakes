import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    
    GMSServices.provideAPIKey("AIzaSyBlS-paSMpCzpRV6qIdmnBb9H0t_CxjkqQ")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
