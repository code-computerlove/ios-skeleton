import XCTest
@testable import DPPMigrationApp

class ApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHmacGeneration() {
        let api = Api()
        let hmac = api.generateSignature("7fa18245-df86-439d-9761-2760f6eb35c6", httpVerb: "GET", contentMd5: "", contentType: "", date: "Fri, 02 Oct 2015 17:00:07 +0100", requestUri: "/api/deployment/45a767c4-8be2-430d-9ff1-c5d6a099e38f/cultures")
        XCTAssertEqual(hmac, "FPTmJYZjAYJEdZJqXFlokpWPSt0=")
    }
//
//    func testFlattenRequestParams() {
//        let requestParams = ["param1":"param1", "param2":"param2", "anotherParam":"forTestingOrder"]
//        let api = Api()
//        let flattenedParams = api.flattenRequestParameters(requestParams)
//        XCTAssertEqual(flattenedParams, "anotherparam:forTestingOrder\nparam1:param1\nparam2:param2\n")
//    }
    
}
