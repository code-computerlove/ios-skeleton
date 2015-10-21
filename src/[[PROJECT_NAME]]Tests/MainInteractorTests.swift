import XCTest
import ObjectMapper
@testable import DPPMigrationApp

class MainInteractorTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testCalculateMediaBytesToDownload() {
		
		let mediaJson = [
			"mediaId": "1234",
			"path": "/",
			"filesize": 1000,
			"width": 100,
			"height": 100,
			"lastModified": "2015-10-09'T'10:00:00.000Z"
		]
		
		let mediaItem = Mapper<MediaEntity>().map(mediaJson)
		var mediaArray = Array<MediaEntity>()
		
		for _ in 1...32 {
			mediaArray.append(mediaItem!)
		}
		
		let mainInteractor = MainInteractor()
		let totalMediaBytes = mainInteractor.calculateTotalMediaBytesToDownload(mediaArray)
		
		XCTAssertEqual(totalMediaBytes, 32000)
	}
}
var mediaId: String!
var path: String!
var filesize: NSNumber!
var width: NSNumber!
var height: NSNumber!
var lastModified: NSDate!