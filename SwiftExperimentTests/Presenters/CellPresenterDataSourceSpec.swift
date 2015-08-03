import Quick
import Nimble
import SwiftExperiment

public class MockCellPresenter: CellPresenter {
  public static func register(tableView tableView: UITableView) {
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  public func present(cell: UITableViewCell) {}
  public func cellIdentifier() -> String { return "Cell" }
}

class CellPresenterDataSourceSpec: QuickSpec {
  override func spec() {
    var subject: CellPresenterDataSource!

    beforeEach {
      subject = CellPresenterDataSource()
    }

    describe("displayCellPresentersInTableView") {
      let tableView = UITableView(frame: CGRectMake(0, 0, 100, 100), style: UITableViewStyle.Plain)
      let cellPresenter0 = MockCellPresenter()
      let cellPresenter1 = MockCellPresenter()
      var cells = []

      beforeEach {
        MockCellPresenter.register(tableView: tableView)

        subject.display(cellPresenters: [cellPresenter0, cellPresenter1], tableView: tableView)

        tableView.layoutIfNeeded()
        cells = tableView.visibleCells
      }

      describe("the table view") {
        it("has two cells") {
          expect(cells.count).to(equal(2))
        }
      }
    }
  }
}
