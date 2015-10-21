import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var mainWireframe: MainWireframe?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		let appConfig = createAppConfiguration()
		self.mainWireframe = MainWireframe(initWithWindow:self.window, config:appConfig)
		
		return true
	}
	
	func createAppConfiguration() {
		
		let appConfig = AppConfig()
		
		let documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
		let contentDirPath = documentsPath.stringByAppendingPathComponent("content");
		
//		
//		if (![[NSFileManager defaultManager] fileExistsAtPath:contentDirPath]) {
//			[[NSFileManager defaultManager] createDirectoryAtPath:contentDirPath withIntermediateDirectories:NO attributes:nil error:nil];
//		}
//		
//		NSString *appContentFilePath = [contentDirPath stringByAppendingPathComponent:@"content.json"];
//		
//		appConfig.contentExists = [[NSFileManager defaultManager] fileExistsAtPath:appContentFilePath];
//		appConfig.appContentFilePath = appContentFilePath;
		
		return appConfig;
	}
}

