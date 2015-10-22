import Foundation
import SwiftyJSON


protocol DataStoreReaderProtocol {
	
	init(path: String)
	func hasData() -> Bool
	func getObjectForKey(key: String) -> AnyObject?
	func getObjectForKeyPath(keyPath: AnyObject...) -> AnyObject?
	func getDataStoreAbsolutePath(relativePath: String) -> String?
}