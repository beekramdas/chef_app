import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chef_app/models/restaurantModel.dart';
import 'package:chef_app/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepository restaurantRepository;

  StreamSubscription<RestaurantModel?>? _restaurantSubscription;

  RestaurantCubit({required this.restaurantRepository})
    : super(RestaurantState.initial());

  Future<void> addRestaurant({
    required String userId,
    required String resName,
    required String role,
    required String phone,
    required String address,
    required List<File> files,
  }) async {
    if (resName.isEmpty || phone.isEmpty || address.isEmpty) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errMsg: 'Please fill all the fields',
        ),
      );
      return;
    }
    if (files.isEmpty) {
      emit(
        state.copyWith(
          isSuccess: false,
          isLoading: false,
          errMsg: "Please upload at least one file",
        ),
      );
      return;
    }
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false, errMsg: ''));
      final exist = await restaurantRepository.restaurantExists(userId);
      if (exist) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            errMsg: "Restaurant already exists",
          ),
        );
        return;
      }
      final imageUrls = await restaurantRepository.uploadMultipleFiles(files);
      final restaurant = RestaurantModel(
        res_id: '',
        userId: userId,
        res_name: resName,
        role: role,
        res_phone: phone,
        res_address: address,
        res_images: imageUrls,
      );
      await restaurantRepository.addRestaurant(restaurant);
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSuccess: false,
          isLoading: false,
          errMsg: e.toString(),
        ),
      );
    }
  }

  /*
  ==========================
  GET RESTAURANT
  ==========================
   */

  void getRestaurant(String userId) {
    emit(state.copyWith(isLoading: true));

    _restaurantSubscription?.cancel();

    _restaurantSubscription = restaurantRepository
        .getRestaurant(userId)
        .listen(
          (restaurant) {
            emit(state.copyWith(restaurant: restaurant, isLoading: false));
          },

          onError: (error) {
            emit(state.copyWith(isLoading: false, errMsg: error.toString()));
          },
        );
  }

  void resetState() {
    emit(RestaurantState.initial());
  }

  @override
  Future<void> close() {
    _restaurantSubscription?.cancel();

    return super.close();
  }
}
