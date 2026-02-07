class Product {
  final String id;
  final String productName;
  final List<String> productImages;
  final int productPrice;
  final List<String> ingredients;
  final String productDesc;
  final double productRating;
  final bool pickup;
  final bool delivery;

  Product({
    this.id = "", // Firestore auto ID
    required this.productName,
    required this.productImages,
    required this.productPrice,
    required this.ingredients,
    required this.productDesc,
    required this.productRating,
    this.pickup = false,
    this.delivery = false,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',

      productName: map['productName'] ?? '',

      productImages: List<String>.from(map['productImages'] ?? []),

      productPrice: map['productPrice'] ?? 0,

      ingredients: List<String>.from(map['ingredients'] ?? []),

      productDesc: map['productDesc'] ?? '',

      productRating: (map['productRating'] as num?)?.toDouble() ?? 0.0,

      pickup: map['pickup'] ?? false,

      delivery: map['delivery'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productName': this.productName,
      'productImages': this.productImages,
      'productPrice': this.productPrice,
      'ingredients': this.ingredients,
      'productDesc': this.productDesc,
      'productRating': this.productRating,
      'pickup': this.pickup,
      'delivery': this.delivery,
    };
  }

  //

  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, productImages: $productImages, productPrice: $productPrice, ingredients: $ingredients, productDesc: $productDesc, productRating: $productRating, pickup: $pickup, delivery: $delivery}';
  }

  Product copyWith({
    String? id,
    String? productName,
    List<String>? productImages,
    int? productPrice,
    List<String>? ingredients,
    String? productDesc,
    double? productRating,
    bool? pickup,
    bool? delivery,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImages: productImages ?? this.productImages,
      productPrice: productPrice ?? this.productPrice,
      ingredients: ingredients ?? this.ingredients,
      productDesc: productDesc ?? this.productDesc,
      productRating: productRating ?? this.productRating,
      pickup: pickup ?? this.pickup,
      delivery: delivery ?? this.delivery,
    );
  }
}
