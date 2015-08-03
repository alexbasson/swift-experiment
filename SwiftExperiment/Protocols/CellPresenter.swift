import UIKit

public protocol CellPresenter {
  static func register(tableView tableView: UITableView) -> Void
  func present(cell: UITableViewCell) -> Void
  func cellIdentifier() -> String
}
