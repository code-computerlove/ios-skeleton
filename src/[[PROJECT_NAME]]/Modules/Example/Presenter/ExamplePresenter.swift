import Foundation


class ExamplePresenter: ExamplePresenterProtocol, ExampleInteractorOutputProtocol {
	
	private weak var view: ExampleViewProtocol?
	private let interactor: ExampleInteractorInputProtocol
	private let wireframe: ExampleWireframeProtocol
	
	var viewModel: ExampleViewModel?
	
	
	//ExamplePresenterProtocol Functions
	
	required init(view: ExampleViewProtocol, interactor: ExampleInteractorInputProtocol, wireframe: ExampleWireframeProtocol) {
		
		self.userInterface = view
		self.interactor = interactor
		self.wireframe = wireframe
	}
	
	func prepareView() {
		self.view?.setTitle(viewModel?.title)
	}
}