import Foundation
import UIKit


class MainViewController: UIViewController, MainViewProtocol {
	
	var eventHandler: MainPresenterProtocol!
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		self.eventHandler.prepareView()
	}
	
	
	//MainViewProtocol Functions
}