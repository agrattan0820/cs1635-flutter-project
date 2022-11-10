class ListFoodEntry {
  final String name;
  // final String category;
  // final String image;
  final String storage;
  final int quantity;
  final String owner;
  final int daysToExpire;

  ListFoodEntry({
    required this.name,
    // required this.category,
    // required this.image,
    this.storage = "any",
    this.quantity = 1,
    this.owner = "",
    this.daysToExpire = 5,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      name: json["name"],
      // category: json["category"],
      // image: json["image"],
      storage: json["storage"],
      quantity: json["quantity"],
      owner: json["owner"],
      daysToExpire: json["daysToExpire"],
    );
  }
}
