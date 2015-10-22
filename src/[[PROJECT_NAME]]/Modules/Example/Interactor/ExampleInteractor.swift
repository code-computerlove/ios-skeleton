import Foundation

class ExampleInteractor: ExampleInteractorInputProtocol {
	
	weak var presenter: ExampleInteractorOutputProtocol?
	private let dataManager: ExampleDataManagerProtocol
	
	
	// ExampleInteractorInputProtocol Functions
	
	required init(dataManager: ExampleDataManagerProtocol) {
		self.dataManager = dataManager
	}
}