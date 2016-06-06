import Foundation

protocol ApiProtocol {
	
	func post(path: String, parameters: [String: String]?, completionHandler: (responseObject: AnyObject?, error: AuthenticationError?) -> ())
	
	func get(path: String, parameters: [String: String]?, completionHandler: (responseObject: AnyObject?, error: AuthenticationError?) -> ())
}


enum AuthenticationError {
	case InternalError, AuthorisationError
}