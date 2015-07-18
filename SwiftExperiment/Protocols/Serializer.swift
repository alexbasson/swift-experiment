import Foundation

public protocol Serializer {
  func serialize(obj: AnyObject) -> Dictionary<String, AnyObject>
  func deserialize(dict: Dictionary<String, AnyObject>) -> AnyObject
}