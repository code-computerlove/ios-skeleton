import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var mainWireframe: MainWireframe?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		if (self.window != nil) {
			let appConfig = createAppConfiguration()
			self.mainWireframe = MainWireframe(window:self.window!, config:appConfig)
		}
		
		return true
	}
	
	func createAppConfiguration() -> AppConfig {
		
		let appConfig = AppConfig()
		
		let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
		let contentDirPath = paths[0].stringByAppendingPathComponent("content");
		
		if !NSFileManager.defaultManager().fileExistsAtPath(contentDirPath) {
			
			try! NSFileManager.defaultManager().createDirectoryAtPath(contentDirPath, withIntermediateDirectories: false, attributes: nil)
			
			if let appContentFilePath = NSURL(fileURLWithPath: contentDirPath).URLByAppendingPathComponent("content.json").path {
				
				appConfig.appContentFilePath = appContentFilePath
			}
		}

		return appConfig;
	}
}

