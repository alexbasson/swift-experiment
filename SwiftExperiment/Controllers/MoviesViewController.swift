import UIKit

public class MoviesViewController: UIViewController {
    public var moviesView: MoviesView! { return self.view as! MoviesView }

    public var movies = [Movie]()

    override public func viewDidLoad() {
        super.viewDidLoad()

        #if Production
            let plistName = "Production"
        #else
            let pListName = "Test"
        #endif

        if let
            pListFilePath = NSBundle.mainBundle().pathForResource(pListName, ofType: "plist"),
            pList = NSDictionary(contentsOfFile: pListFilePath),
            urlString = pList["MovieServiceURL"] as? String,
            apiKey = pList["MovieServiceAPIKey"] as? String,
            requestString = urlString + "?apikey=" + apiKey as? String,
            url = NSURL(string: requestString)
        {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        if let json = json as? NSDictionary,
                               moviesJson = json["movies"] as? NSArray {
                                let movies: NSMutableArray = []
                                for movieJson in moviesJson {
                                    if let title = movieJson["title"] as? String {
                                        movies.addObject(Movie(title: title))
                                    }
                                }
                                self.movies = movies as NSArray as! [Movie]
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    self.moviesView.tableView?.reloadData()
                                })
                        }
                    } catch {
                        // handle the error if the json parsing fails
                    }
                }
            }
            if let task = task {
                task.resume()
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieTableViewCell", forIndexPath: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        return cell
    }
}
