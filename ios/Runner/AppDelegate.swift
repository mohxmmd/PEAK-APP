import UIKit
import Flutter
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
      UIApplication.shared.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    


    


    override func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError
                     error: Error) {
        // Try again later.
    }
    override func application(_ application: UIApplication,
                              didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data){

                                
                                Messaging.messaging().apnsToken = deviceToken
                                super.application(application, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
                              }
}

