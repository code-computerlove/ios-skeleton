import Foundation
import UIKit


class ExampleViewController: UIViewController, ExampleViewProtocol {
	
	var eventHandler: ExamplePresenterProtocol!
	var viewModel: ExampleViewModel?
	
	@IBOutlet weak var titleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.eventHandler.prepareView()
		self.titleLabel.text = viewModel?.title
	}
	
	
	//ExampleViewProtocol Functions
}