import Foundation

public class JSONClient {

    public init() {}

    public func sendRequest(request: NSURLRequest, closure: (json: AnyObject) -> ()) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                    closure(json: json)
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
