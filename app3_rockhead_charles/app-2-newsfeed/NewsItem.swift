import Foundation

// Model for "NewsItem" goes in this file
struct NewsItem {
    // TODO: we need to store 1) the post title and 2) whether or not the post is favorited. One of these properties can change, and one cannot.
    let title: String
    var starred: Bool = false
    init(_  title: String, _ starred: Bool) {
        self.title = title
        self.starred = starred
    }
}
