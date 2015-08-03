import UIKit
import SwiftExperiment

class MockCellPresenterDataSource: CellPresenterDataSource {
  var receivedDisplayCellPresentersInTableView = false
  var displayCellPresentersInTableViewParams: (cellPresenters: [CellPresenter], tableView: UITableView?)!

  override func displayCellPresentersInTableView(cellPresenters cellPresenters: [CellPresenter], tableView: UITableView?) {
    receivedDisplayCellPresentersInTableView = true
    displayCellPresentersInTableViewParams = (cellPresenters: cellPresenters, tableView: tableView)
  }
}

extension MockCellPresenterDataSource: Mockable {
  func resetSentMessages() {
    receivedDisplayCellPresentersInTableView = false
  }
}
