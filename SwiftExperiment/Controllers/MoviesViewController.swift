import UIKit

public class MoviesViewController: UIViewController {
    public var moviesView: MoviesView! { return self.view as! MoviesView }

    public var movies = [String]()

}

extension MoviesViewController: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MovieTableViewCell
        cell.titleLabel.text = movies[indexPath.row]
        return cell
    }
}
