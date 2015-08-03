import UIKit
import SwiftExperiment

class MockCellPresenterDataSource: CellPresenterDataSource {
  var receivedDisplay = false
  var displayParams: (cellPresenters: [CellPresenter], tableView: UITableView?)!

  override func display(cellPresenters cellPresenters: [CellPresenter], tableView: UITableView?) {
    receivedDisplay = true
    displayParams = (cellPresenters: cellPresenters, tableView: tableView)
  }
}

extension MockCellPresenterDataSource: Mockable {
  func resetSentMessages() {
    receivedDisplay = false
  }
}
