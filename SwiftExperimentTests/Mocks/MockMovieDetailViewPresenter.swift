import UIKit
import SwiftExperiment

class MockMovieDetailViewPresenter: ViewPresenter {
  var receivedPresentInView = false

  func presentInView(view: UIView) {
    receivedPresentInView = true
  }
}