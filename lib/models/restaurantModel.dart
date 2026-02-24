class RestaurantModel {
  String res_id;
  String userId;
  String res_name;
  String role;
  String res_phone;
  String res_address;
  List<String> res_images;

  RestaurantModel({
    required this.res_id,
    required this.userId,
    required this.res_name,
    required this.role,
    required this.res_phone,
    required this.res_address,
    required this.res_images,
  });

  Map<String, dynamic> toMap() {
    return {
      'res_id': this.res_id,
      'userId': this.userId,
      'res_name': this.res_name,
      'role': this.role,
      'res_phone': this.res_phone,
      'res_address': this.res_address,
      'res_images': this.res_images,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      res_id: map['res_id'] as String,
      userId: map['userId'] as String,
      res_name: map['res_name'] as String,
      role: map['role'] as String,
      res_phone: map['res_phone'] as String,
      res_address: map['res_address'] as String,
      res_images: List<String>.from(map['res_images'] ?? []),
    );
  }

  RestaurantModel copyWith({
    String? res_id,
    String? userId,
    String? res_name,
    String? role,
    String? res_phone,
    String? res_address,
    List<String>? res_images,
  }) {
    return RestaurantModel(
      res_id: res_id ?? this.res_id,
      userId: userId ?? this.userId,
      res_name: res_name ?? this.res_name,
      role: role ?? this.role,
      res_phone: res_phone ?? this.res_phone,
      res_address: res_address ?? this.res_address,
      res_images: res_images ?? this.res_images,
    );
  }
}
