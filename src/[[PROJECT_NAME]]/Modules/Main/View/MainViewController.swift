import Foundation
import UIKit


class MainViewController: UIViewController {
	
	var eventHandler: MainPresenterProtocol!
	
	override func viewDidLoad() {

		super.viewDidLoad()
		self.eventHandler.prepareView()
	}
}


extension MainViewController: MainViewProtocol {
	
}