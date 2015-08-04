import SwiftExperiment

class MockMovieService: MovieServiceInterface {
  typealias getMoviesTuple = (wasReceived: Bool, closure: MovieServiceClosure!)

  var getMovies: getMoviesTuple = (wasReceived: false, closure: nil)
  func getMovies(closure: MovieServiceClosure) {
    getMovies = (wasReceived: true, closure: closure)
  }
}

extension MockMovieService: Mockable {
  func resetSentMessages() {
    getMovies = (wasReceived: false, closure: nil)
  }
}
