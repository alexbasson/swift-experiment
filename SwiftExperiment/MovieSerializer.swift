import Foundation

public class MovieSerializer: Serializer {
  public init() {}

  public func serialize(obj: AnyObject) -> Dictionary<String, AnyObject> {
    let movie = obj as! Movie
    return ["title": movie.title]
  }

  public func deserialize(dict: Dictionary<String, AnyObject>) -> AnyObject {
    return Movie(title: dict["title"] as! String)
  }
}
