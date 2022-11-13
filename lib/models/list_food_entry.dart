class ListFoodEntry {
  final String name;
  final String storage;
  final int quantity;
  final String owner;
  final DateTime expirationDate;

  ListFoodEntry({
    required this.name,
    required this.storage,
    this.quantity = 1,
    this.owner = "",
    required this.expirationDate,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      name: json["name"],
      storage: json["storage"],
      quantity: json["quantity"],
      owner: json["owner"],
      expirationDate: json["expirationDate"],
    );
  }
}
