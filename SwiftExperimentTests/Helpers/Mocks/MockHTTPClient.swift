import Foundation
import SwiftExperiment

public class MockHTTPClient: HTTPClientInterface {
  public var receivedSendRequest = false
  public var requestParam: NSURLRequest!
  public var sendRequestClosure: HTTPClientClosure!

  public func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    receivedSendRequest = true
    requestParam = request
    sendRequestClosure = closure
  }
}

