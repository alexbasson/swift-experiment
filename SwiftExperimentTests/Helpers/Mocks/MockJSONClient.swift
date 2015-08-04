import Foundation
import SwiftExperiment

class MockJSONClient: JSONClientInterface {
  typealias sendRequestTuple = (wasReceived: Bool, params: (request: NSURLRequest!, closure: JSONClientClosure!))

  var sendRequest: sendRequestTuple = (wasReceived: false, params: (request: nil, closure: nil))
  func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    sendRequest = (wasReceived: true, params: (request: request, closure: closure))
  }
}

extension MockJSONClient: Mockable {
  func resetSentMessages() {
    sendRequest = (wasReceived: false, params: (request: nil, closure: nil))
  }
}