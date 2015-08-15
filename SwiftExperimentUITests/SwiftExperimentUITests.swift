import Foundation
import XCTest

class SwiftExperimentUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    continueAfterFailure = false
    XCUIApplication().launch()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testUserSeesMoviesList() {
    let app = XCUIApplication()
    let table = app.tables
    table.staticTexts["Ant-Man"].tap()
  }

}
