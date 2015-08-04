import UIKit

public protocol ViewPresenter {
  func present(view: UIView) -> Void
}