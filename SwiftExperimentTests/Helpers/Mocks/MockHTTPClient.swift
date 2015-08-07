import Foundation
import SwiftExperiment

class MockHTTPClient: HTTPClientInterface {
  class SendRequestParams {
    var request: NSURLRequest!
    var closure: HTTPClientClosure!

    init(request: NSURLRequest, closure: HTTPClientClosure) {
      self.request = request
      self.closure = closure
    }
  }

  var sendRequestInvocation = Invocation(wasReceived: false, params: nil)
  func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    sendRequestInvocation.wasReceived = true
    sendRequestInvocation.params = SendRequestParams(request: request, closure: closure)
  }
}

extension MockHTTPClient: Mockable {
  func resetSentMessages() {
    sendRequestInvocation.wasReceived = false
    sendRequestInvocation.params = nil;
  }
}

