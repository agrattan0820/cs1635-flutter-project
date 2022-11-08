class ListFoodEntry {
  final String name;
  final String category;
  final String image;
  final int daysToExpire;

  ListFoodEntry({
    required this.name,
    required this.category,
    required this.image,
    this.daysToExpire = 5,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      name: json["name"],
      category: json["category"],
      image: json["image"],
      daysToExpire: json["daysToExpire"],
    );
  }
}
