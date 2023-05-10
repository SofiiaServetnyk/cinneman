class Ticket {
  final int id;
  final int movieId;
  final String name;
  final DateTime date;
  final String image;
  final String smallImage;

  Ticket({
    required this.id,
    required this.movieId,
    required this.name,
    required this.date,
    required this.image,
    required this.smallImage,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      movieId: json['movieId'],
      name: json['name'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
      image: json['image'],
      smallImage: json['smallImage'],
    );
  }
}
