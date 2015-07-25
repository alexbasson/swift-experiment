import Foundation

public typealias HTTPClientClosure = (data: NSData?, error: NSError?) -> Void

public protocol HTTPClientInterface {
  func sendRequest(request: NSURLRequest, closure: HTTPClientClosure)
}