import Foundation
import SwiftExperiment

class MockHTTPClient: HTTPClientInterface {
  var receivedSendRequest = false
  var sendRequestParams: (request: NSURLRequest, closure: HTTPClientClosure)!

  func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    receivedSendRequest = true
    sendRequestParams = (request: request, closure: closure)
  }
}

extension MockHTTPClient: Mockable {
  func resetSentMessages() {
    receivedSendRequest = false
  }
}

