class Product {
  final String id;
  final String productName;
  final List<String> productImages;
  final int productPrice;
  final List<String> ingredients;
  final String productDesc;
  final double productRating;

  Product({
    this.id = "", // Firestore auto ID
    required this.productName,
    required this.productImages,
    required this.productPrice,
    required this.ingredients,
    required this.productDesc,
    required this.productRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productName': this.productName,
      'productImages': this.productImages,
      'productPrice': this.productPrice,
      'ingredients': this.ingredients,
      'productDesc': this.productDesc,
      'productRating': this.productRating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      productName: map['productName'] as String,
      productImages: map['productImages'] as List<String>,
      productPrice: map['productPrice'] as int,
      ingredients: map['ingredients'] as List<String>,
      productDesc: map['productDesc'] as String,
      productRating: map['productRating'] as double,
    );
  }
}
