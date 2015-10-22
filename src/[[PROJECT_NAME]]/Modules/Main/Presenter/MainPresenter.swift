import Foundation
import ObjectMapper


class MainPresenter: NSObject, MainPresenterProtocol, MainInteractorOutputProtocol {
	
	private weak var userInterface: MainViewProtocol?
	private let interactor: MainInteractorInputProtocol
	private let wireframe: MainWireframeProtocol
	
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