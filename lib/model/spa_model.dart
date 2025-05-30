class Spa {
  final String name;
  final String image;
  final String location;
  final String rating;
  final String distance;
  final String discount;
  final String description;
  final String gender;

  Spa({
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.distance,
    required this.discount,
    required this.description,
    required this.gender,
  });

  factory Spa.fromJson(Map<String, dynamic> json) {
    return Spa(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      rating: json['rating'] ?? '4.5',
      distance: json['distance'] ?? '3.5 km',
      discount: json['discount'] ?? '',
      description: json['description'] ?? '',
      gender: json['gender'] ?? 'Unisex',
    );
  }
}
