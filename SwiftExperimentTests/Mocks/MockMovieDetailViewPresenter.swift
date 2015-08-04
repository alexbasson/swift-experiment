import UIKit
import SwiftExperiment

class MockMovieDetailViewPresenter: ViewPresenter {
  typealias presentTuple = (wasReceived: Bool, view: UIView!)

  var present: presentTuple = (wasReceived: false, view: nil)
  func presentInView(view: UIView) {
    present = (wasReceived: true, view: view)
  }
}

extension MockMovieDetailViewPresenter: Mockable {
  func resetSentMessages() {
    present = (wasReceived: false, view: nil)
  }
}