import Quick
import Nimble

@testable import [[PROJECT_NAME]]

class DataStoreSpec: QuickSpec {

    override func spec(){
        describe("When using the PList data store"){

            describe("delete data from the data store"){
                context("when the object key is provided"){
                    it("should remove that object"){
                        let data: [String: AnyObject] = [
                            "startTime" : "2015-08-12 08:00:00",
                            "endTime" : "2015-08-12 18:00:00",
                            "username" : "test@test.com"
                        ]

                        let dataStore = PlistFileDataStore(data: data)
                        dataStore.addObject("authorisation", object: "token")

                        dataStore.removeObject("authorisation")
                        expect(dataStore.data).to(equal(data))

                    }
                }
            }

            describe("add data to the Plist data store"){
                context("when one object is added"){
                    it("should store the correct data"){
                        let expectedData: [String: AnyObject] = [
                            "authorisation": "token"
                        ]

                        let dataStore = PlistFileDataStore(data: [:])
                        dataStore.addObject("authorisation", object: "token")

                        let storedData = dataStore.data

                        expect(storedData).to(equal(expectedData))
                    }
                }
            }

            describe("update data in the data store"){
                context("when changing value of an object"){
                    it("should update the object to the new value"){
                        let storedData: [String: AnyObject] = [
                            "authorisation": "12345"
                        ]
                        let expectedData: [String: AnyObject] = [
                            "authorisation": "00000"
                        ]

                        let dataStore = PlistFileDataStore(data: storedData)

                        dataStore.removeObject("authorisation")
                        dataStore.addObject("authorisation", object: "00000")

                        expect(dataStore.data).to(equal(expectedData))
                    }
                }
            }

        }
    }

}
