import Foundation
import SwiftyJSON
import ObjectMapper

class PlistFileDataStore: DataStoreReaderProtocol, DataStoreWriterProtocol {
	
	enum DataError : ErrorType {
		case ErrorWithMessage(message: String)
	}
	
	private let filePath: String
	var data: NSDictionary?
	
	required init(path: String) {
		self.filePath = path;
		
		if NSFileManager.defaultManager().fileExistsAtPath(self.filePath) {
			if let data = NSDictionary(contentsOfFile: filePath) {
				self.data = data
			}
		}
	}
	
	init(data: [String: AnyObject]) {
		
		self.filePath = ""
		self.data = data
	}
	
	func hasData() -> Bool {
		if let validData = data {
			return validData.count > 0
		}
		
		return false
	}
	
	func getRootObject() -> [String : AnyObject]? {
		return self.data as? [String: AnyObject]
	}
	
	func getObjectForKey(key: String) -> AnyObject? {
		return self.data?[key]
	}
	
	func removeObject(key: String) {
		let mutable = self.data?.mutableCopy()
		mutable?.removeObjectForKey(key)
		self.data = mutable?.copy() as? NSDictionary
	}
	
	func getObjectForKeyPath(keyPath: AnyObject...) -> AnyObject? {
		
		let subMap: [String] = keyPath.map { (sub) in
			return String(sub)
		}
		
		return self.data?[subMap]
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
		var mutableData = data as! [String: AnyObject]
		mutableData[key] = object
		self.data = mutableData as NSDictionary
	}
	
	func overwriteData(data: String) throws {
		
		if let dataData = data.dataUsingEncoding(NSUTF8StringEncoding) {
			self.data = NSKeyedUnarchiver.unarchiveObjectWithData(dataData) as? [String: AnyObject]
		}
		
		try self.persistData();
	}
	
	func persistData() throws {
		data?.writeToFile(self.filePath, atomically: true)
	}
 
}