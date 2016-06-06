import Foundation
import ObjectMapper


class ISO8601DateTransformer: TransformType {
	
	private let dateFormatter = NSDateFormatter()
	
	init() {
		dateFormatter.locale = NSLocale(localeIdentifier: "en_GB_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
	}
	
	func transformFromJSON(value: AnyObject?) -> NSDate? {
		
		if let dateString = value as? String {
			let date = dateFormatter.dateFromString(dateString)
			return date
		}
		
		return nil
	}
	
	func transformToJSON(value: NSDate?) -> String? {
		
		if let date = value {
			return dateFormatter.stringFromDate(date)
		}
		
		return nil
	}
}