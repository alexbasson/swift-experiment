import UIKit

public extension UITableViewCell {
  public class func reuseIdentifier() -> String {
    let className = NSStringFromClass(self)
    let classNameComponents = split(className.characters) { $0 == "." }.map{ String($0) }
    return classNameComponents[1]
  }
}