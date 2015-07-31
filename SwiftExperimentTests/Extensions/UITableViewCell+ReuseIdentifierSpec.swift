import Quick
import Nimble
import SwiftExperiment

class ArbitraryTableViewCell: UITableViewCell {}

class UITableViewCell_ReuseIdentifierSpec: QuickSpec {

    override func spec() {
      describe("reuseIdentifier()") {
        it("returns the class name") {
          expect(ArbitraryTableViewCell.reuseIdentifier()).to(equal("ArbitraryTableViewCell"))
        }
      }
    }
}
