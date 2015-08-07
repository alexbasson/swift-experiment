import Foundation
import SwiftExperiment

class MockRequestProvider: RequestProvider {
  let fakeGetMoviesRequest = NSURLRequest()

  var getMoviesRequestInvocation = Invocation(wasReceived: false, params: nil)
  override func getMoviesRequest() -> NSURLRequest? {
    getMoviesRequestInvocation.wasReceived = true
    return fakeGetMoviesRequest
  }
}

extension MockRequestProvider: Mockable {
  func resetSentMessages() {
    getMoviesRequestInvocation.wasReceived = false
  }
}
