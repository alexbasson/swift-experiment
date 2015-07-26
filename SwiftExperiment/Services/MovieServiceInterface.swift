import Foundation

public typealias MovieServiceClosure = (movies: [Movie]?, error: NSError?) -> ()

public protocol MovieServiceInterface {
  func getMovies(closure: MovieServiceClosure)
}