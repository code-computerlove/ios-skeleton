import Foundation
import SwiftyJSON
import ObjectMapper


class MainDataManager {
	
	private let dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>
	
	required init(dataStore: protocol<DataStoreReaderProtocol, DataStoreWriterProtocol>) {
		self.dataStore = dataStore
	}
}


extension MainDataManager: MainDataManagerProtocol {
	
}