import XCTest

class SwiftExperimentUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testExample() {
      let app = XCUIApplication()
      let table = app.tables
      table.staticTexts["Ant-Man"].tap()
    }

}
