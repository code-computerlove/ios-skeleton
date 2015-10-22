import Foundation

class ExampleInteractor: ExampleInteractorInputProtocol {
	
	weak var presenter: ExampleInteractorOutputProtocol?
	let dataManager: ExampleDataManagerProtocol
	
	
	// ExampleInteractorInputProtocol Functions
	
	required init(dataManager: ExampleDataManagerProtocol) {
		self.dataManager = dataManager
	}
}