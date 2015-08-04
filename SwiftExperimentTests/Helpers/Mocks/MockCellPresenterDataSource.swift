import UIKit
import SwiftExperiment

class MockCellPresenterDataSource: CellPresenterDataSource {
  typealias displayTuple = (wasReceived: Bool, params: (cellPresenters: [CellPresenter]!, tableView: UITableView!))

  var display: displayTuple = (wasReceived: false, params: (cellPresenters: nil, tableView: nil))
  override func display(cellPresenters cellPresenters: [CellPresenter], tableView: UITableView?) {
    display = (wasReceived: true, params: (cellPresenters: cellPresenters, tableView: tableView))
  }
}

extension MockCellPresenterDataSource: Mockable {
  func resetSentMessages() {
    display = (wasReceived: false, params: (cellPresenters: nil, tableView: nil))
  }
}
