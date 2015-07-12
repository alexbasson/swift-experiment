import Foundation

public class MovieService {
    let requestProvider: RequestProvider
    let jsonClient: JSONClient

    public init(requestProvider: RequestProvider, jsonClient: JSONClient) {
        self.requestProvider = requestProvider
        self.jsonClient = jsonClient
    }

    public convenience init() {
        self.init(requestProvider: RequestProvider(), jsonClient: JSONClient())
    }

    public func getMovies(closure: ([Movie]) -> ()) {
        if let request = requestProvider.getMoviesRequest() {
            jsonClient.sendRequest(request) {
                (let json) in
                if let moviesJson = json["movies"] as? NSArray {
                    let movies: NSMutableArray = []
                    for movieJson in moviesJson {
                        if let title = movieJson["title"] as? String {
                            movies.addObject(Movie(title: title))
                        }
                    }
                    closure(movies as NSArray as! [Movie])
                }
            }
        }
    }
}
