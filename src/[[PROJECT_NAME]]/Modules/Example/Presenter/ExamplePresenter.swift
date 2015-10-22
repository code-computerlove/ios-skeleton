import Foundation

class ExamplePresenter: ExamplePresenterProtocol, ExampleInteractorOutputProtocol {
	
	let userInterface: ExampleViewProtocol
	let interactor: ExampleInteractorInputProtocol
	let wireframe: ExampleWireframeProtocol
	
	//ExamplePresenterProtocol Functions
	
	required init(view: ExampleViewProtocol, interactor: ExampleInteractorInputProtocol, wireframe: ExampleWireframeProtocol) {
		
		self.userInterface = view
		self.interactor = interactor
		self.wireframe = wireframe
	}
	
	func prepareView() {
		
	}
}