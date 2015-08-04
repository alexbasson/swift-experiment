import Foundation
import SwiftExperiment

class MockHTTPClient: HTTPClientInterface {
  typealias sendRequestTuple = (wasReceived: Bool, params: (request: NSURLRequest!, closure: HTTPClientClosure!))

  var sendRequest: sendRequestTuple = (wasReceived: false, params: (request: nil, closure: nil))
  func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    sendRequest = (wasReceived: true, params: (request: request, closure: closure))
  }
}

extension MockHTTPClient: Mockable {
  func resetSentMessages() {
    sendRequest = (wasReceived: false, params: (request: nil, closure: nil))
  }
}

