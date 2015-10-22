import Foundation
import UIKit


class Router: NSObject {

	weak var navigationController: UINavigationController?
	var topViewController: UIViewController
	
	init(rootViewController: UIViewController, navigationController: UINavigationController) {
		
		self.topViewController = rootViewController
		self.navigationController = navigationController
		
		super.init()
	}
	
	func isViewControllerPresented(viewController: UIViewController) -> Bool {
		return (self.navigationController?.topViewController?.isKindOfClass(viewController.classForCoder))!
	}
	
	func navigateToViewController(viewController: UIViewController) {
		
		self.topViewController = viewController;
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}