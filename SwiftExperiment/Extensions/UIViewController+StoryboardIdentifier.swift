import UIKit

public extension UIViewController {
  public class func storyboardIdentifier() -> String {
    let className = NSStringFromClass(self)
    let classNameComponents = split(className.characters) { $0 == "." }.map{ String($0) }
    return classNameComponents[1]
  }

  public class func getInstanceFromStoryboard(name: String) -> UIViewController {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    return storyboard.instantiateViewControllerWithIdentifier(self.storyboardIdentifier())
  }
}