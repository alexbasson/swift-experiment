import Foundation
import SwiftExperiment

extension Movie {

  public convenience init(title: String) {
    self.init(title: title, posters: Posters())
  }

  public convenience init() {
    self.init(title: "A title", posters: Posters())
  }
}