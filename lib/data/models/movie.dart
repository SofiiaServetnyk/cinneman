class Movie {
  int id;
  String name;
  int age;
  String trailer;
  String image;
  String smallImage;
  String originalName;
  int duration;
  String language;
  String rating;
  int year;
  String country;
  String genre;
  String plot;
  String starring;
  String director;
  String screenwriter;
  String studio;

  Movie({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        trailer: json["trailer"],
        image: json["image"],
        smallImage: json["smallImage"],
        originalName: json["originalName"],
        duration: json["duration"],
        language: json["language"],
        rating: json["rating"],
        year: json["year"],
        country: json["country"],
        genre: json["genre"],
        plot: json["plot"],
        starring: json["starring"],
        director: json["director"],
        screenwriter: json["screenwriter"],
        studio: json["studio"],
      );
}
