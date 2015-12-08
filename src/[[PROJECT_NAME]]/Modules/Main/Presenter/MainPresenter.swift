import Foundation
import ObjectMapper


class MainPresenter {
	
	private weak var view: MainViewProtocol?
	private let interactor: MainInteractorInputProtocol
	private let wireframe: MainWireframeProtocol
	
	required init(
		view: MainViewProtocol, 
		interactor: MainInteractorInputProtocol, 
		wireframe: MainWireframeProtocol) {
			self.userInterface = view
			self.interactor = interactor
			self.wireframe = wireframe
	}
}


extension MainPresenter: MainPresenterProtocol {
	
	func prepareView() {
		
	}
}


extension MainPresenter: MainInteractorOutputProtocol {
	
}