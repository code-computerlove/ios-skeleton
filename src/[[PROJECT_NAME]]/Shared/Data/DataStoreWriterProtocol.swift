import Foundation


protocol DataStoreWriterProtocol {
	
	func addObject(key: String, object: AnyObject)
	func overwriteData(data: String) throws
	func persistData() throws
}
