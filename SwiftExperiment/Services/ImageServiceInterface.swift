import UIKit

public typealias ImageServiceClosure = (image: UIImage) -> Void

public protocol ImageServiceInterface {
  func fetchImage(url url: NSURL, closure: ImageServiceClosure) -> Void
}
