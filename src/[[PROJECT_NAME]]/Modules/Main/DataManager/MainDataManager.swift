import Foundation
import SwiftyJSON
import ObjectMapper


class MainDataManager: MainDataManagerProtocol {
	
	private let dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>
	
	// MainDataManagerProtocol Functions
	
	required init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>) {
		self.dataStore = dataStore
	}
}