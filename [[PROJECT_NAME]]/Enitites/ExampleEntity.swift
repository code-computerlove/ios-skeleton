import Foundation
import ObjectMapper

@objc class ExampleEntity: NSObject, Mappable {

	var title: String!
	
	struct K {
		static let title = "title"
	}
	
	required init?(_ map: Map) {
		
	}
	
	func mapping(map: Map) {
		
		title			<- map[K.title]
	}
}