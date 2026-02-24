part of 'restaurant_cubit.dart';

class RestaurantState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errMsg;
  final RestaurantModel? restaurant;

  const RestaurantState({
    required this.isLoading,
    required this.isSuccess,
    required this.errMsg,
    required this.restaurant,
  });

  factory RestaurantState.initial() {
    return RestaurantState(
      isLoading: false,
      isSuccess: false,
      errMsg: '',
      restaurant: null,
    );
  }

  @override
  String toString() {
    return 'RestaurantState{isLoading: $isLoading, isSuccess: $isSuccess, errMsg: $errMsg, restaurant: $restaurant}';
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errMsg, restaurant];

  RestaurantState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errMsg,
    RestaurantModel? restaurant,
  }) {
    return RestaurantState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errMsg: errMsg ?? this.errMsg,
      restaurant: restaurant ?? this.restaurant,
    );
  }
}
