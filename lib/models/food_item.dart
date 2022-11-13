class FoodItem {
  final int id;
  final String name;
  final String category;
  final String image;
  final int daysToExpire;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    this.daysToExpire = 5,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      image: json["image"],
      daysToExpire: json["daysToExpire"],
    );
  }
}
