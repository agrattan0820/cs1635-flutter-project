class ListFoodEntry {
  final int entryId;
  final int foodId;
  String storage;
  int quantity;
  String owner;
  final DateTime dateAdded;

  ListFoodEntry({
    required this.entryId,
    required this.foodId,
    this.storage = "any",
    this.quantity = 1,
    this.owner = "",
    required this.dateAdded,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      entryId: json['entryId'],
      foodId: json["foodId"],
      storage: json["storage"],
      quantity: json["quantity"],
      owner: json["owner"],
      dateAdded: json["dateAdded"],
    );
  }
}
