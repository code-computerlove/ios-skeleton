import Foundation
import Alamofire
import CryptoSwift


class Api {
	
	let JSONParsingErrorDomain = "JSONParsingErrorDomain"
	let FileErrorDomain = "FileErrorDomain"
	var dateFormatter: NSDateFormatter
	let baseUrl: String
	
	required init(baseUrl: String) {
		self.baseUrl = baseUrl
		
		dateFormatter = NSDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier:"en_GB")
		dateFormatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss Z"
	}
	
	func request(
		httpMethod: String,
		path: String,
		parameters: [String: String]?,
		completionHandler: (responseObject: AnyObject?, error: AuthenticationError?) -> ()) {
			
			let requestWithError = constructUrlRequest(path,
				params: parameters,
				httpMethod: httpMethod)
			
			if let authError = requestWithError.error {
				let convertedError = convertError(authError.code)
				completionHandler(responseObject: nil, error: convertedError)
				return
			}
			
			Alamofire.request(requestWithError.request).responseJSON {
				request, response, result in
				
				let authError = self.convertError(response?.statusCode)
				
				if let resultDictionary = result.value as? NSDictionary {
					completionHandler(responseObject: resultDictionary, error: authError)
					return
				}
				
				if let resultArray = result.value as? NSArray {
					completionHandler(responseObject: resultArray, error: authError)
					return
				}
				
				completionHandler(responseObject: nil, error: authError)
			}
	}
	
	func convertError(statusCode: Int?) -> AuthenticationError? {
		if statusCode == 400 {
			return .AuthorisationError
		} else if statusCode == 500 {
			return .AuthorisationError
		} else if statusCode != 200 {
			return .InternalError
		}
		return nil
	}
	
	func constructUrlRequest(
		url: String,
		params: [String: String]?,
		httpMethod: String) -> (request: NSURLRequest, error: NSError?) {
			
			let urlRequest = NSMutableURLRequest(URL: NSURL(string: self.baseUrl + url)!)
			urlRequest.HTTPMethod = httpMethod
			
			let contentType = Constants.API.RequestContentType;
			urlRequest.setValue(contentType, forHTTPHeaderField: Constants.API.ContentTypeKey)
			
			let dateString = dateFormatter.stringFromDate(NSDate())
			urlRequest.setValue(dateString, forHTTPHeaderField: Constants.API.Authentication.HeaderDateKey)
			
			if let hash = generateSignature(
				Constants.API.Authentication.DecryptionKey,
				httpVerb: urlRequest.HTTPMethod,
				contentMd5: flattenRequestParameters(params).md5(),
				contentType: contentType,
				date: dateString,
				requestUri: url) {
					
					urlRequest.setValue(hash as String,
						forHTTPHeaderField: Constants.API.Authentication.HeaderSignatureKey)
			}
			
			let encoding:ParameterEncoding = .URL
			let encodedURLRequest = encoding.encode(urlRequest, parameters: params)
			
			return (encodedURLRequest.0.copy() as! NSURLRequest, encodedURLRequest.1)
	}
	
	func flattenRequestParameters(parameters: [String: String]?) -> String {
		
		guard let validParams = parameters else {
			return ""
		}
		
		let sortedParams = validParams.sort { $0.0 < $1.0 }
		var flatParams = ""
		
		sortedParams.forEach { (key, val) -> () in
			flatParams += "\(key.lowercaseString):\(val)\\n"
		}
		
		return flatParams
	}
	
	func generateSignature(secret: String, httpVerb: String, contentMd5: String, contentType: String, date: String, requestUri: String) -> NSString? {
		
		let secretBytes = Array(secret.utf8)
		let messageBytes = Array("\(httpVerb)\\n\(contentMd5)\\n\(contentType)\\n\(date)\\n\(requestUri)".utf8)
		
		do {
			let authenticator = Authenticator.HMAC(key: secretBytes, variant: HMAC.Variant.sha1)
			let mac = try authenticator.authenticate(messageBytes)
			return NSString(data: NSData.withBytes(mac), encoding: NSUTF8StringEncoding)
		} catch {
			NSLog("Could not authenticate HMAC string")
		}
		
		return nil
	}
}


extension Api: ApiProtocol {
	
	func post(path: String, parameters: [String: String]?, completionHandler: (responseObject: AnyObject?, error: AuthenticationError?) -> ()) {
		request("POST", path: path, parameters: parameters, completionHandler: completionHandler)
	}
	
	func get(path: String, parameters: [String: String]?, completionHandler: (responseObject: AnyObject?, error: AuthenticationError?) -> ()) {
		request("GET", path: path, parameters: parameters, completionHandler: completionHandler)
	}
}
