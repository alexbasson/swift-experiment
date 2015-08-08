import Foundation
import SwiftExperiment

class MockJSONClient: JSONClientInterface {
  class SendRequestParams {
    var request: NSURLRequest!
    var closure: JSONClientClosure!

    init(request: NSURLRequest, closure: JSONClientClosure) {
      self.request = request
      self.closure = closure
    }
  }

  var sendRequestInvocation = Invocation(wasReceived: false, params: nil)
  func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    sendRequestInvocation.wasReceived = true
    sendRequestInvocation.params = SendRequestParams(request: request, closure: closure)
  }
}

extension MockJSONClient: Mockable {
  func resetSentMessages() {
    sendRequestInvocation.wasReceived = false
    sendRequestInvocation.params = nil
  }
}