import Foundation
import ObjectMapper

public class ISO8601DateTransformer: TransformType {
	
	public typealias Object = NSDate
	public typealias JSON = String
	
	private let dateFormatter = NSDateFormatter()
	
	public init() {
		
		dateFormatter.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
	}
	
	public func transformFromJSON(value: AnyObject?) -> NSDate? {
		
		if let dateString = value as? String {
			let date = dateFormatter.dateFromString(dateString)
			return date
		}
		
		return nil
	}
	
	public func transformToJSON(value: NSDate?) -> String? {
		
		if let date = value {
			return dateFormatter.stringFromDate(date)
		}
		
		return nil
	}
}