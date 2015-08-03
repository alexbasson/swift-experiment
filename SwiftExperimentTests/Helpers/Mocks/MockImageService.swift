import Foundation
import SwiftExperiment

class MockImageService: ImageServiceInterface {
  var receivedFetchImage = false
  var fetchImageURLParam: NSURL!
  var fetchImageClosure: ImageServiceClosure!
  var fetchImageParams: (url: NSURL, closure: ImageServiceClosure)!

  func fetchImage(url url: NSURL, closure: ImageServiceClosure) {
    receivedFetchImage = true
    fetchImageParams = (url: url, closure: closure)
  }
}

extension MockImageService: Mockable {
  func resetSentMessages() {
    receivedFetchImage = false
  }
}