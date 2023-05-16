class Product {
  final int productId;
  final String title;
  final String? productDescription;
  final int price;
  final double? rating;
  final String? imageUrl;
  final String? image;
  final int isAvailableForSale;

  Product(
      {required this.productId,
      required this.title,
      required this.productDescription,
      required this.price,
      required this.rating,
      required this.imageUrl,
      required this.image,
      required this.isAvailableForSale});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      title: json['title'],
      productDescription: json['productDescription'],
      price: json['price'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      image: json['image'],
      isAvailableForSale: json['isAvailableForSale'],
    );
  }
}
