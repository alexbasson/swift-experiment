import Foundation

public class MovieService: MovieServiceInterface {
  public static let sharedInstance = MovieService(requestProvider: RequestProvider(), jsonClient: JSONClient())
  let requestProvider: RequestProvider
  let jsonClient: JSONClientInterface

  public init(requestProvider: RequestProvider, jsonClient: JSONClientInterface) {
    self.requestProvider = requestProvider
    self.jsonClient = jsonClient
  }

  public func getMovies(closure: MovieServiceClosure) {
    if let request = requestProvider.getMoviesRequest() {
      jsonClient.sendRequest(request) {
        (json, error) in
        if let
          json = json,
          moviesJSON = json["movies"] as? [Dictionary<String, AnyObject>] {
            var movies: [Movie] = []
            for movieJSON in moviesJSON {
              let movie = Movie(dict: movieJSON)
              movies.append(movie)
            }
            closure(movies: movies, error: nil)
        } else if let error = error {
          closure(movies: nil, error: error)
        }
      }
    }
  }
}
