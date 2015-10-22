import Foundation


class ExamplePresenter: ExamplePresenterProtocol, ExampleInteractorOutputProtocol {
	
	private weak var userInterface: ExampleViewProtocol?
	private let interactor: ExampleInteractorInputProtocol
	private let wireframe: ExampleWireframeProtocol
	
	//ExamplePresenterProtocol Functions
	
	required init(view: ExampleViewProtocol, interactor: ExampleInteractorInputProtocol, wireframe: ExampleWireframeProtocol) {
		
		self.userInterface = view
		self.interactor = interactor
		self.wireframe = wireframe
	}
	
	func prepareView() {
		
	}
}