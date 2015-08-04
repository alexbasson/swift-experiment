import Foundation
import SwiftExperiment

class MockRequestProvider: RequestProvider {
  let fakeGetMoviesRequest = NSURLRequest()

  var getMoviesRequestWasReceived = false
  override func getMoviesRequest() -> NSURLRequest? {
    getMoviesRequestWasReceived = true
    return fakeGetMoviesRequest
  }
}

extension MockRequestProvider: Mockable {
  func resetSentMessages() {
    getMoviesRequestWasReceived = false
  }
}
