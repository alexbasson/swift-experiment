import UIKit

public protocol ViewPresenter {
  func presentInView(view: UIView) -> Void
}