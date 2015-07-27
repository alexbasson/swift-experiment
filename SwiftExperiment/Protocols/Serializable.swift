import Foundation

public protocol Serializable {
  func serialize() -> Dictionary<String, AnyObject>
  init(dict: Dictionary<String, AnyObject>)
}
