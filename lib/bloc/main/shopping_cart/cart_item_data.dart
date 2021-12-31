class CartItemData {

  final String previewImagePath;
  final String description;
  final String title;
  final int price;

  CartItemData({
    required this.previewImagePath,
    required this.description,
    required this.title,
    required this.price
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) {
    return CartItemData(
      previewImagePath: json['previewImagePath'] ?? '',
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
    );
  }
}