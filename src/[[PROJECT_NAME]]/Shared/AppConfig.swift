import Foundation


class AppConfig: NSObject {
	
	var appContentFilePath: String?

	static func create() -> AppConfig {
		
		let appConfig = AppConfig()
		createAppFileStructure(appConfig)
		
		return appConfig;
	}
	
	private static func createAppFileStructure(appConfig: AppConfig) {
		
		let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
		var isDir : ObjCBool = true
		
		let contentDirPath = paths[0].stringByAppendingPathComponent("content");
		if !NSFileManager.defaultManager().fileExistsAtPath(contentDirPath, isDirectory: &isDir) {
			try! NSFileManager.defaultManager().createDirectoryAtPath(contentDirPath, withIntermediateDirectories: false, attributes: nil)
		}
		
		let mediaDirPath =  paths[0].stringByAppendingPathComponent("content/media");
		if !NSFileManager.defaultManager().fileExistsAtPath(mediaDirPath, isDirectory: &isDir) {
			try! NSFileManager.defaultManager().createDirectoryAtPath(mediaDirPath, withIntermediateDirectories: false, attributes: nil)
		}
		
		let contentDirUrl = NSURL(fileURLWithPath: contentDirPath)
		
		appConfig.appContentFilePath =
			getFilePath(contentDirUrl, filename: "content.json", createFromBundle: false)
	}
	
	private static func getFilePath(contentDirUrl: NSURL, filename: String, createFromBundle: Bool) -> String {
		
		if let filePath = contentDirUrl.URLByAppendingPathComponent(filename).path {
			if createFromBundle && !NSFileManager.defaultManager().fileExistsAtPath(filePath) {
				
				let bundle = NSBundle.mainBundle()
				let filenameParts = filename.characters.split{$0 == "."}.map(String.init)
				
				if let bundlePath = bundle.pathForResource(filenameParts[0], ofType: filenameParts[1]) {
					try! NSFileManager.defaultManager().copyItemAtPath(bundlePath, toPath: filePath)
				}
			}
			
			return filePath
		}
		
		return ""
	}
}