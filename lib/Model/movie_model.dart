class MovieModel {
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
  MovieModel({this.id, this.title, this.titleLong, this.body,  this.isSelected, this.year, this.rating, this.language, this.backgroundImage, this.uploadedDate, this.genres});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleLong = json['title_long'];
    body = json['summary'];
    year = json['year'];
    rating = json['rating'];
    language = json['language'];
    backgroundImage = "https://www.yts.nz/${json['background_image_original']}";
    uploadedDate = json['date_uploaded'];
    genres = json['genres'].cast<String>();
  }
}