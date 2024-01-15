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
    backgroundImage = "https://www.yts.nz/${json['large_cover_image']}";
    uploadedDate = json['date_uploaded'] ?? '';
    genres = json['genres'].cast<String>();
  }
}