import Foundation

public class Movie: Serializable {
  public var title: String
  public var posters: Posters

  public init(title: String, posters: Posters) {
    self.title = title
    self.posters = posters
  }

  public func serialize() -> Dictionary<String, AnyObject> {
    return [
      "title": title,
      "posters": posters.serialize()
    ]
  }

  public convenience required init(dict: Dictionary<String, AnyObject>) {
    self.init(title: dict["title"] as! String,
              posters: Posters(dict: dict["posters"] as! Dictionary))
  }
}

extension Movie: Equatable {}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
  return lhs.title == rhs.title && lhs.posters == rhs.posters
}

