import Foundation

public typealias JSONClientClosure = (json: AnyObject?, error: NSError?) -> ()

public class JSONClient {

    public init() {}

    public func sendRequest(request: NSURLRequest, closure: JSONClientClosure) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                    closure(json: json, error: nil)
                } catch {
                    // handle the error if the data is unable to be parsed into json object
                }
            }
        }
        if let task = task {
            task.resume()
        }
    }
}
