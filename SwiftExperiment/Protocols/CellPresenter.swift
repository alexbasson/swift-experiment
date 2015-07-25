import UIKit

public protocol CellPresenter {
  static func registerInTableView(tableView: UITableView) -> Void
  func presentInCell(cell: UITableViewCell) -> Void
  func cellIdentifier() -> String
}
