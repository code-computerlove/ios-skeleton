import Foundation
import UIKit


class Router: NSObject {
	
	let navigationController: UINavigationController
	var topViewController: UIViewController
	
	init(rootViewController: UIViewController, navigationController: UINavigationController) {
		
		self.topViewController = rootViewController
		self.navigationController = navigationController

		super.init()
		
		self.navigationController.delegate = self
	}
	
	func isViewControllerPresented(viewController: UIViewController) -> Bool {
		return (self.navigationController.topViewController?.isKindOfClass(viewController.classForCoder))!
	}
	
	func navigateToViewController(viewController: UIViewController) {
		self.navigationController.pushViewController(viewController, animated: true)
	}
	
	func resetViewStack(viewController: UIViewController) {
		self.navigationController.viewControllers = [viewController]
	}
}


extension Router: UINavigationControllerDelegate {
	
	@objc func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
		self.topViewController = viewController
	}
}