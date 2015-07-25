import Foundation

public typealias JSONClientClosure = (json: AnyObject?, error: NSError?) -> ()

public protocol JSONClientInterface {
  func sendRequest(request: NSURLRequest, closure: JSONClientClosure)
}
