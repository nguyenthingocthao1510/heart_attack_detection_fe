class LatestNews {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  LatestNews({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory LatestNews.fromMap(Map<String, dynamic> e) {
    return LatestNews(
      source: Source.fromMap(e['source']),
      author: e['author'],
      title: e['title'],
      description: e['description'],
      url: e['url'],
      urlToImage: e['urlToImage'],
      publishedAt: e['publishedAt'],
      content: e['content'],
    );
  }
}

class Source {
  String? name;

  Source({this.name});

  factory Source.fromMap(Map<String, dynamic> sourceMap) {
    return Source(
      name: sourceMap['name'],
    );
  }
}
