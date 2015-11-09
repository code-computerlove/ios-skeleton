import Foundation
import UIKit


class ExampleViewController: UIViewController, ExampleViewProtocol {
	
	var eventHandler: ExamplePresenterProtocol!
	
	@IBOutlet weak var titleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.eventHandler.prepareView()
	}
	
	
	//ExampleViewProtocol Functions
	
	func setTitle(title: String?) {
		self.titleLabel.text = title
	}
}