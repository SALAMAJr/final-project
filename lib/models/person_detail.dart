class PersonDetail {
  final int id;
  final String name;
  final String biography;
  final String birthday;
  final String placeOfBirth;

  PersonDetail({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
  });

  factory PersonDetail.fromJson(Map<String, dynamic> json) {
    return PersonDetail(
      id: json['id'],
      name: json['name'],
      biography: json['biography'] ?? 'No biography available.',
      birthday: json['birthday'] ?? 'Unknown',
      placeOfBirth: json['place_of_birth'] ?? 'Unknown',
    );
  }
}
