class Character {
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  Character({
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'status': status,
        'species': species,
        'gender': gender,
        'image': image,
      };
}
