import UIKit

extension UIViewController {
  func renderView(inNavController inNavController: Bool) {
    if let window = UIApplication.sharedApplication().keyWindow {
      if (inNavController) {
        let navController = UINavigationController(rootViewController: self)
        window.rootViewController = navController
      } else {
        window.rootViewController = self
      }
      NSRunLoop.mainRunLoop().runUntilDate(NSDate())
    }
  }

  func renderView() {
    self.renderView(inNavController: false)
  }

  func renderViewInNavController() {
    self.renderView(inNavController: true)
  }
}
