import UIKit
import SwiftExperiment

public class MockCellPresenterDataSource: CellPresenterDataSource {
  public var receivedDisplayCellPresentersInTableView = false
  public var cellPresentersParam: [CellPresenter]!
  public var tableViewParam: UITableView!

  public override func displayCellPresentersInTableView(cellPresenters cellPresenters: [CellPresenter], tableView: UITableView?) {
    receivedDisplayCellPresentersInTableView = true
    cellPresentersParam = cellPresenters
    tableViewParam = tableView
  }
}
