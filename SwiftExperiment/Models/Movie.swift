import Foundation

public class Movie: Serializable {
  public let title: String
  public let thumbnailURL: NSURL

  public init(title: String, thumbnailURL: NSURL) {
    self.title = title
    self.thumbnailURL = thumbnailURL
  }

  public func serialize() -> Dictionary<String, AnyObject> {
    return ["title": title]
  }

  public convenience required init(dict: Dictionary<String, AnyObject>) {
    let title = dict["title"] as! String
    let posters = dict["posters"] as! Dictionary<String, AnyObject>
    let thumbnailURL = posters["thumbnail"] as! String
    self.init(title: title, thumbnailURL: NSURL(string: thumbnailURL)!)
  }
}

extension Movie: Equatable {}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
  return lhs.title == rhs.title
}

