import UIKit
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var mainWireframe: MainWireframe?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		if (self.window != nil) {
			self.mainWireframe = MainWireframe(
				window: self.window!, 
				config: AppConfig.create())
			
			application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
			self.window!.backgroundColor = UIColor.whiteColor()
		}
		
		Fabric.with([Crashlytics.self])
		
		return true
	}
}

