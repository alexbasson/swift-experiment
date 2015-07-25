import Quick
import Nimble
import SwiftExperiment

public class MockCellPresenter: CellPresenter {
  public static func registerInTableView(tableView: UITableView) {
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  public func presentInCell(cell: UITableViewCell) {}
  public func cellIdentifier() -> String { return "Cell" }
}

class CellPresenterDataSourceSpec: QuickSpec {
  override func spec() {
    var subject: CellPresenterDataSource!

    beforeEach {
      subject = CellPresenterDataSource()
    }

    describe("displayCellPresentersInTableView") {
      var tableView: UITableView!
      var cellPresenter0: MockCellPresenter!
      var cellPresenter1: MockCellPresenter!
      var cells = []

      beforeEach {
        tableView = UITableView(frame: CGRectMake(0, 0, 100, 100), style: UITableViewStyle.Plain)
        MockCellPresenter.registerInTableView(tableView)
        cellPresenter0 = MockCellPresenter()
        cellPresenter1 = MockCellPresenter()

        subject.displayCellPresentersInTableView(cellPresenters: [cellPresenter0, cellPresenter1], tableView: tableView)

        tableView.layoutIfNeeded()
        cells = tableView.visibleCells
      }

      describe("the table view") {
        it("has two cells") {
          expect(cells.count).to(equal(2))
        }
//
//            it("sets the title of the first cell to 'Wall-E'") {
//              let cell: MovieTableViewCell = cells[0] as! MovieTableViewCell
//              expect(cell.titleLabel.text).to(equal("Wall-E"))
//            }
//
//            it("sets the title of the second cell to 'Up'") {
//              let cell: MovieTableViewCell = cells[1] as! MovieTableViewCell
//              expect(cell.titleLabel.text).to(equal("Up"))
//            }
      }
    }
  }
}
