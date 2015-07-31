import Foundation
import SwiftExperiment

public class MockJSONClient: JSONClientInterface {
  public var receivedSendRequest = false
  public var requestParam: NSURLRequest!
  public var sendRequestClosure: JSONClientClosure!

  public func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    receivedSendRequest = true
    requestParam = request
    sendRequestClosure = closure
  }
}
