import Foundation

public protocol Serializable {
  func serialize(obj: Self) -> Dictionary<String, AnyObject>
  init(dict: Dictionary<String, AnyObject>)
}
