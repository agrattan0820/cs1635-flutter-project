class ListFoodEntry {
  final int id;
  final String storage;
  final int quantity;
  final String owner;
  final DateTime dateAdded;

  ListFoodEntry({
    required this.id,
    this.storage = "any",
    this.quantity = 1,
    this.owner = "",
    required this.dateAdded,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      id: json["id"],
      storage: json["storage"],
      quantity: json["quantity"],
      owner: json["owner"],
      dateAdded: json["dateAdded"],
    );
  }
}
