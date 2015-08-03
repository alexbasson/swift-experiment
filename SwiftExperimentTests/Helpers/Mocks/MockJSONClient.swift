import Foundation
import SwiftExperiment

class MockJSONClient: JSONClientInterface {
  var receivedSendRequest = false
  var sendRequestParams: (request: NSURLRequest, closure: JSONClientClosure)!

  func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    receivedSendRequest = true
    sendRequestParams = (request: request, closure: closure)
  }
}

extension MockJSONClient: Mockable {
  func resetSentMessages() {
    receivedSendRequest = false
  }
}