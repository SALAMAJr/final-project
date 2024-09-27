class FamousPerson {
  final int id;
  final String name;
  final String profilePath;

  FamousPerson({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory FamousPerson.fromJson(Map<String, dynamic> json) {
    return FamousPerson(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
