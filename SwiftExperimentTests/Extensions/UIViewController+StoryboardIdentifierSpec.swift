import Quick
import Nimble
import SwiftExperiment

class ArbitraryViewController: UIViewController {}

class UIViewController_StoryboardIdentifierSpec: QuickSpec {
    override func spec() {
      describe("storyboardIdentifier()") {
        it("returns the class name") {
          expect(ArbitraryViewController.storyboardIdentifier()).to(equal("ArbitraryViewController"))
        }
      }
    }
}
