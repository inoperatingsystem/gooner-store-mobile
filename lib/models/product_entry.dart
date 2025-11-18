// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    String description;
    String category;
    String? thumbnail; // Optional
    int stock;
    String size;
    int soldCount;
    DateTime dateAdded;
    bool isFeatured;
    bool isAvailable;
    int userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.category,
        this.thumbnail,
        required this.stock,
        required this.size,
        required this.soldCount,
        required this.dateAdded,
        required this.isFeatured,
        required this.isAvailable,
        required this.userId,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        stock: json["stock"],
        size: json["size"],
        soldCount: json["sold_count"],
        dateAdded: DateTime.parse(json["date_added"]),
        isFeatured: json["is_featured"],
        isAvailable: json["is_available"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "stock": stock,
        "size": size,
        "sold_count": soldCount,
        "date_added": dateAdded.toIso8601String(),
        "is_featured": isFeatured,
        "is_available": isAvailable,
        "user_id": userId,
    };
}
