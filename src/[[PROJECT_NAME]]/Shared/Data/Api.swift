import Foundation
import Alamofire
import CryptoSwift


class Api {
    
    let JSONParsingErrorDomain = "JSONParsingErrorDomain"
    let FileErrorDomain = "FileErrorDomain"
    var dateFormatter: NSDateFormatter
	let baseUrl: String
	let downloadDirectoryUrl: NSURL
	
	required init(baseUrl: String, downloadDirectoryUrl: NSURL) {
		
		self.baseUrl = baseUrl
		self.downloadDirectoryUrl = downloadDirectoryUrl
		
        dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier:"en_GB")
        dateFormatter.dateFormat = "EEE',' dd MMM yyyy HH':'mm':'ss Z"
    }
    
    func post(path: String, parameters: Dictionary<String, String>, completionHandler: (responseObject: AnyObject?, error: NSError?) -> ()) {
        request("POST", path: path, parameters: parameters, completionHandler: completionHandler)
    }
    
    func get(path: String, parameters: Dictionary<String, String>, completionHandler: (responseObject: AnyObject?, error: NSError?) -> ()) {
        request("GET", path: path, parameters: parameters, completionHandler: completionHandler)
    }
    
    func downloadFile(path: String, outputPathUrl: String, parameters : Dictionary<String,String>, completionHandler: (responseObject: NSDictionary?, error: ErrorType?) -> (), progressBlock: (bytesRead: Int64) -> ()){

        let requestWithError = constructUrlRequest(path, params: parameters, httpMethod: "POST")
        
        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
            (temporaryURL, response) in

            return self.downloadDirectoryUrl
        }
        
        Alamofire.download(requestWithError.request, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                progressBlock(bytesRead: bytesRead)
            }
            .response { request, response, data, error in
                completionHandler(responseObject: nil, error: error)
            }
    }
    
    
    //Private methods
    
    private func request(httpMethod: String, path: String, parameters: Dictionary<String, String>, completionHandler: (responseObject: AnyObject?, error: NSError?) -> ()) {

        let requestWithError = constructUrlRequest(path, params: parameters, httpMethod: httpMethod)
        
        if (requestWithError.error != nil) {
            completionHandler(responseObject: nil, error: requestWithError.error)
            return
        }
        
        Alamofire.request(requestWithError.request)
            .responseJSON {
                request, response, result in
				
                if let resultDictionary = result.value as? NSDictionary {
                    completionHandler(responseObject: resultDictionary, error: result.error as? NSError)
					return
                }
				
				if let resultArray = result.value as? NSArray {
                    completionHandler(responseObject: resultArray, error: result.error as? NSError)
					return
                }
				
				completionHandler(responseObject: nil, error: NSError(domain: self.JSONParsingErrorDomain, code: -101, userInfo: nil))
        }
    }
        
    private func constructUrlRequest(url: String, params: Dictionary<String, String>, httpMethod: String) -> (request: NSURLRequest, error: NSError?) {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: self.baseUrl + url)!)
        urlRequest.HTTPMethod = httpMethod
		
		let flattenedParams = flattenRequestParameters(params)
		let hashedRequestBody = flattenedParams.md5() ?? flattenedParams
		
        let contentType = Constants.API.RequestContentType;
		urlRequest.setValue(contentType, forHTTPHeaderField: Constants.API.ContentTypeKey)
		
        let dateString = dateFormatter.stringFromDate(NSDate())
        urlRequest.setValue(dateString, forHTTPHeaderField: Constants.API.Authentication.HeaderDateKey)
		
		if let hash = generateSignature(
			Constants.API.Authentication.DecryptionKey,
			httpVerb: urlRequest.HTTPMethod,
			contentMd5: hashedRequestBody,
			contentType: contentType,
			date: dateString,
			requestUri: url) {
		
			urlRequest.setValue(hash as String, forHTTPHeaderField: Constants.API.Authentication.HeaderSignatureKey)
		}
		
        let encoding:ParameterEncoding = .URL
        let encodedURLRequest = encoding.encode(urlRequest, parameters: params)

        return (encodedURLRequest.0.copy() as! NSURLRequest, encodedURLRequest.1)
    }
    
    func flattenRequestParameters(parameters: Dictionary<String, String>) -> String {
        
        if (parameters.count == 0) {
            return ""
        }
        
        let sortedParams = parameters.sort { $0.0 < $1.0 }
        let flatParams: NSMutableString? = ""
        
        for param in sortedParams {
            flatParams?.appendFormat("%@:%@\n", param.0.lowercaseString, param.1)
        }
        
        return ((flatParams?.copy()) as? String)!
    }
    
    func generateSignature(secret: String, httpVerb: String, contentMd5: String, contentType: String, date: String, requestUri: String) -> NSString? {
		
        let message = String(format:"%@\n%@\n%@\n%@\n%@", httpVerb, contentMd5, contentType, date, requestUri)
		
		let secretBytes = Array(secret.utf8)
		let messageBytes = Array(message.utf8)
		
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
