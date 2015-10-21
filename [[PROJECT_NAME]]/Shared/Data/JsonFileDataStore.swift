import Foundation
import SwiftyJSON
import ObjectMapper

@objc class JsonFileDataStore : NSObject, DataStoreReaderProtocol, DataStoreWriterProtocol {
	
	enum DataError : ErrorType {
		case ErrorWithMessage(message: String)
	}
	
	private let filePath: String
	var data: JSON?
	
	required init(path: String) {
		
		self.filePath = path;

		super.init()
		
		if NSFileManager.defaultManager().fileExistsAtPath(self.filePath) {
			self.loadDataFromStorage()
		}
	}
	
	func hasData() -> Bool {
		return data != nil
	}

	func getObjectForKey(key: String) -> AnyObject? {
		return self.data?[key].object
	}
	
	func getObjectForKeyPath(keyPath: AnyObject...) -> AnyObject? {

		let subMap: [JSONSubscriptType] = keyPath.map { (sub) in
			if sub is String {
				return String(sub)
			}
			
			if sub is Int {
				return sub as! Int
			}
			
			return ""
		}

		return self.data?[subMap].object
	}
	
	func getDataStoreAbsolutePath(relativePath: String) -> String? {
		
		if let url = NSURL(string: self.filePath) {
			if let url = url.URLByDeletingLastPathComponent {
				return url.URLByAppendingPathComponent(relativePath).absoluteString
			}
		}

		return nil
	}
	
	func addObject(key: String, object: AnyObject) {
		self.data?[key] = JSON(object)
	}
	
	func overwriteData(data: String) throws {
		
		self.data = JSON(data)
		try self.persistData();
		
		loadDataFromStorage()
	}
	
	func persistData() throws {
		
		let rawData = data?.rawString()
		
		do {
			try rawData!.writeToFile(self.filePath, atomically: true, encoding: NSUTF8StringEncoding)
		} catch {
			throw DataError.ErrorWithMessage(message: "Data could not be deserialized for saving")
		}
	}
	
	private func loadDataFromStorage() {
		
		let contentData = NSData(contentsOfFile: self.filePath)!
		self.data = JSON(data: contentData)
	}
}