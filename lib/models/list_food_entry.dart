class ListFoodEntry {
  final int id;
  String storage;
  int quantity;
  String owner;
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
