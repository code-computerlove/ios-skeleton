import Foundation
import SwiftyJSON


class MainInteractor {

	weak var presenter: MainInteractorOutputProtocol?
	private let dataManager: MainDataManagerProtocol
	
	required init(dataManager: MainDataManagerProtocol) {
		self.dataManager = dataManager
	}
}


extension MainInteractor: MainInteractorInputProtocol {
	
}