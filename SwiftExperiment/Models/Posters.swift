import Foundation

public class Posters: Serializable {
  public var thumbnailURL: NSURL
  public var profileURL: NSURL
  public var detailedURL: NSURL
  public var originalURL: NSURL

  public init(thumbnailURL: NSURL, profileURL: NSURL, detailedURL: NSURL, originalURL: NSURL) {
    self.thumbnailURL = thumbnailURL
    self.profileURL = profileURL
    self.detailedURL = detailedURL
    self.originalURL = originalURL
  }

  public func serialize() -> Dictionary<String, AnyObject> {
    return [
      "thumbnail": thumbnailURL.absoluteString,
      "profile": profileURL.absoluteString,
      "detailed": detailedURL.absoluteString,
      "original": originalURL.absoluteString
    ]
  }

  public convenience required init(dict: Dictionary<String, AnyObject>) {
    let thumbnail = dict["thumbnail"] as! String
    let profile = dict["profile"] as! String
    let detailed = dict["detailed"] as! String
    let original = dict["original"] as! String
    self.init(thumbnailURL: NSURL(string: thumbnail)!,
              profileURL: NSURL(string: profile)!,
              detailedURL: NSURL(string: detailed)!,
              originalURL: NSURL(string: original)!)
  }
}

extension Posters: Equatable {}

public func==(lhs: Posters, rhs: Posters) -> Bool {
  return lhs.thumbnailURL == rhs.thumbnailURL &&
         lhs.profileURL == rhs.profileURL &&
         lhs.detailedURL == rhs.detailedURL &&
         lhs.originalURL == rhs.originalURL
}