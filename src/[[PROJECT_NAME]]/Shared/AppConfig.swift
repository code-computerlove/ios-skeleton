import Foundation


class AppConfig {
	
	var appContentFilePath: String
	var settingsFilePath: String
	var mediaDirectoryPath: String
	
	static func create() -> AppConfig {
		return AppConfig()
	}
	
	init() {
		
		let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
		var isDir : ObjCBool = true
		
		let contentDirPath = paths[0].stringByAppendingPathComponent("content");
		if !NSFileManager.defaultManager().fileExistsAtPath(contentDirPath, isDirectory: &isDir) {
			try! NSFileManager.defaultManager().createDirectoryAtPath(contentDirPath, withIntermediateDirectories: false, attributes: nil)
		}
		
		mediaDirectoryPath = paths[0].stringByAppendingPathComponent("content/media");
		
		if !NSFileManager.defaultManager().fileExistsAtPath(mediaDirectoryPath, isDirectory: &isDir) {
			try! NSFileManager.defaultManager().createDirectoryAtPath(mediaDirectoryPath,
				withIntermediateDirectories: false, attributes: nil)
		}
		
		appContentFilePath = AppConfig.getFilePath(contentDirPath,
			filename: "content.json",
			createFromBundle: true)
		settingsFilePath = AppConfig.getFilePath(contentDirPath,
			filename: "settings.plist",
			createFromBundle: true)
	}
	
	private static func getFilePath(directoryPath: String, filename: String, createFromBundle: Bool) -> String {
		
		let directoryUrl = NSURL(fileURLWithPath: directoryPath)
		
		if let filePath = directoryUrl.URLByAppendingPathComponent(filename).path {
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
