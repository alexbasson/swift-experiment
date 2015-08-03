import Foundation
import SwiftExperiment

public class MockRequestProvider: RequestProvider {
  public var receivedGetMoviesRequest = false
  public let fakeGetMoviesRequest = NSURLRequest()

  override public func getMoviesRequest() -> NSURLRequest? {
    receivedGetMoviesRequest = true
    return fakeGetMoviesRequest
  }
}

extension MockRequestProvider: Mockable {
  func resetSentMessages() {
    receivedGetMoviesRequest = false
  }
}
