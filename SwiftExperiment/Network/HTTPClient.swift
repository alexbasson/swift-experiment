import Foundation

public class HTTPClient: HTTPClientInterface {
  let session: NSURLSession

  public init(session: NSURLSession) {
    self.session = session
  }

  public convenience init() {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    self.init(session: session)
  }

  public func sendRequest(request: NSURLRequest, closure: HTTPClientClosure) {
    let task = session.dataTaskWithRequest(request) {
      (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
      closure(data: data, error: error)
    }
    task.resume()
  }
}
