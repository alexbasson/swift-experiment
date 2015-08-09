import Foundation

public class RequestProvider {

  public init() {}

  public func getMoviesRequest() -> NSURLRequest? {
    if let
      pList = NSBundle.mainBundle().infoDictionary,
      movieServiceDict = pList["Movie service"] as? NSDictionary,
      urlString = movieServiceDict["URL"] as? String,
      apiKey = movieServiceDict["APIKey"] as? String,
      requestString = urlString + "?apikey=" + apiKey as? String,
      url = NSURL(string: requestString)
    {
      return NSURLRequest(URL: url)
    }
    return nil
  }
}
