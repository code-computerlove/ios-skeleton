import Foundation
import ObjectMapper

@objc class MainPresenter: NSObject, MainPresenterProtocol, MainInteractorOutputProtocol {
	
	let userInterface: MainViewProtocol
	let interactor: MainInteractorInputProtocol
	let wireframe: MainWireframeProtocol
	
	//MainPresenterProtocol Functions
	
	required init(view: MainViewProtocol, interactor: MainInteractorInputProtocol, wireframe: MainWireframeProtocol) {

		self.userInterface = view
		self.interactor = interactor
		self.wireframe = wireframe

		super.init()
	}
	
	func prepareView() {
		let viewModel = ExampleViewModel(title: "Example View Model")
		self.wireframe.presentRootScreen(viewModel)
	}
}