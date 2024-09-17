class ApiResponse {
  final bool success;
  final String? message;
  final Data data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String link;
  final String image;
  final String description;
  final String title;
  final List<Post> posts;

  Data({
    required this.link,
    required this.image,
    required this.description,
    required this.title,
    required this.posts,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var postList = json['posts'] as List;
    List<Post> posts = postList.map((i) => Post.fromJson(i)).toList();

    return Data(
      link: json['link'],
      image: json['image'],
      description: json['description'],
      title: json['title'],
      posts: posts,
    );
  }
}

class Post {
  final String link;
  final String title;
  final String pubDate;
  final String description;
  final String thumbnail;

  Post({
    required this.link,
    required this.title,
    required this.pubDate,
    required this.description,
    required this.thumbnail,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      link: json['link'],
      title: json['title'],
      pubDate: json['pubDate'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}
