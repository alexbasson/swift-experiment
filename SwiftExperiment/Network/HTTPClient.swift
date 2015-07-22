import Foundation

public typealias HTTPClientClosure = (data: NSData?, error: NSError?) -> Void

public class HTTPClient {
  let session: NSURLSession

  public init(session: NSURLSession) {
    self.session = session
  }

  public convenience init() {
    self.init(session: NSURLSession.sharedSession())
  }

  public func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    let task = session.dataTaskWithRequest(request) {
      (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
      closure(data: data, error: error)
    }
    task.resume()
  }
}
