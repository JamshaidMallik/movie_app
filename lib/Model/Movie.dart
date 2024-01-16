class Movie {
  int? id;
  String? title;
  String? titleLong;
  String? body;
  bool? isSelected = false;
  var year;
  var rating;
  String? language;
  String? backgroundImage;
  String? uploadedDate;
  List<String>? genres = [];
  Movie({this.id, this.title, this.titleLong, this.body,  this.isSelected, this.year, this.rating, this.language, this.backgroundImage, this.uploadedDate, this.genres});
  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    titleLong = json['title_long'] ?? '';
    body = json['summary'] ?? '';
    year = json['year'];
    rating = json['rating'];
    language = json['language'];
    backgroundImage = json['large_cover_image'];
    uploadedDate = json['date_uploaded'] ?? '';
    genres = json['genres'].cast<String>();
    isSelected = json['isSelected'] ?? false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title_long'] = titleLong;
    data['summary'] = body;
    data['year'] = year;
    data['rating'] = rating;
    data['language'] = language;
    data['large_cover_image'] = backgroundImage;
    data['date_uploaded'] = uploadedDate;
    data['genres'] = genres;
    data['isSelected'] = true;
    return data;
  }
}