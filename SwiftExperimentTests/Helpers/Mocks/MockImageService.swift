import Foundation
import SwiftExperiment

class MockImageService: ImageServiceInterface {
  typealias fetchImagesTuple = (wasReceived: Bool, params: (url: NSURL!, closure: ImageServiceClosure!))

  var fetchImage: fetchImagesTuple = (wasReceived: false, params: (url: nil, closure: nil))
  func fetchImage(url url: NSURL, closure: ImageServiceClosure) {
    fetchImage = (wasReceived: true, params: (url: url, closure: closure))
  }
}

extension MockImageService: Mockable {
  func resetSentMessages() {
    fetchImage = (wasReceived: false, params: (url: nil, closure: nil))
  }
}