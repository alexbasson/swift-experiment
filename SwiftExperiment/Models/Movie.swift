public class Movie {
  public let title: String

  public init(title: String) {
    self.title = title
  }
}

extension Movie: Equatable {}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
  return lhs.title == rhs.title
}

