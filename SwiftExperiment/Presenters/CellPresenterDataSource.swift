import UIKit

public class CellPresenterDataSource: NSObject {
  var cellPresenters: [CellPresenter]?

  public func display(cellPresenters cellPresenters: [CellPresenter], tableView: UITableView?) -> Void {
    self.cellPresenters = cellPresenters
    if let tableView = tableView {
      tableView.dataSource = self as UITableViewDataSource?
      performOnMainQueue {
        tableView.reloadData()
      }
    }
  }
}

extension CellPresenterDataSource: UITableViewDataSource {
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let cellPresenters = cellPresenters {
      return cellPresenters.count
    } else {
      return 0
    }
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    if let cellPresenters = cellPresenters {
      let cellPresenter = cellPresenters[indexPath.row]
      let cell = tableView.dequeueReusableCellWithIdentifier(cellPresenter.cellIdentifier(), forIndexPath: indexPath)
      cellPresenter.present(cell)
      return cell
    }

    return UITableViewCell()
  }
}