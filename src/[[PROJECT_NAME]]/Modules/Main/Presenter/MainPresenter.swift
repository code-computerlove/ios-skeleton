import Foundation
import ObjectMapper

@objc class MainPresenter: NSObject, MainModulePresenterProtocol, MainModuleInteractorOutputProtocol {
	
	let userInterface: MainModuleViewProtocol
	let interactor: MainModuleInteractorInputProtocol
	let wireframe: MainModuleWireframeProtocol
	
	//MainModulePresenterProtocol Functions
	
	required init(view: MainModuleViewProtocol, interactor: MainModuleInteractorInputProtocol, wireframe: MainModuleWireframeProtocol) {

		self.userInterface = view
		self.interactor = interactor
		self.wireframe = wireframe

		super.init()
	}
	
	func prepareView() {
		self.userInterface.testModuleSetup()
	}
}