import SwiftExperiment

public class MockMovieService: MovieServiceInterface {
  public var receivedGetMovies = false
  public var getMoviesClosure: MovieServiceClosure!

  public func getMovies(closure: MovieServiceClosure) {
    receivedGetMovies = true
    getMoviesClosure = closure
  }
}

extension MockMovieService: Mockable {
  func resetSentMessages() {
    receivedGetMovies = false
  }
}
