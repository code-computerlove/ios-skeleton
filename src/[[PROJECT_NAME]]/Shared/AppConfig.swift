import Foundation


class AppConfig: NSObject {
	
	var appContentFilePath: String?

	static func create() {
		
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