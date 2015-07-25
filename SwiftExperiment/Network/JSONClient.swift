import Foundation

public class JSONClient: JSONClientInterface {
  let httpClient: HTTPClientInterface

  public init(httpClient: HTTPClientInterface) {
    self.httpClient = httpClient
  }

  public convenience init() {
    self.init(httpClient: HTTPClient())
  }

  public func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
    httpClient.sendRequest(request) {
      (data, error) in
      if let data = data {
        do {
          let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
          closure(json: json, error: nil)
        } catch {
          // handle the error if the data is unable to be parsed into json object
        }
      } else if let error = error {
        closure(json: nil, error: error)
      }
    }
  }
}
