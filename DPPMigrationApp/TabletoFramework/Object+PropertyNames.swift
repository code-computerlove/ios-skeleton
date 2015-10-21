import Foundation

extension NSObject {
	
	func propertyNames() -> Array<String> {
		
		var results: Array<String> = [];
		var count: UInt32 = 0;
		let myClass: AnyClass = self.classForCoder;
		let properties = class_copyPropertyList(myClass, &count);

		for var i: UInt32 = 0; i < count; i++ {
			let property = properties[Int(i)];
			let cname = property_getName(property);
			let name = String.fromCString(cname);
			
			results.append(name!);
		}
		
		free(properties);
		return results;
	}
}