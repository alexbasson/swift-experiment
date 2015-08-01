import UIKit

public protocol CellPresenter {
  static func register(tableView tableView: UITableView) -> Void
  func presentInCell(cell: UITableViewCell) -> Void
  func cellIdentifier() -> String
}
