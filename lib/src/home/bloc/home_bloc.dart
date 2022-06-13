import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scanner_mobile/src/home/home.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required UserRepository userRepository}):
        _userRepository = userRepository,
        super(const HomeState()) {
    on<GetUser>(_onGetUser);
    on<GetUserCategories>(_onGetUserCategories);
    on<UploadFiles>(_onUploadFiles);

    add(GetUser());
  }

  final UserRepository _userRepository;

  void _onGetUser(GetUser event, Emitter<HomeState> emit) async {
    emit(state.copyWith(userIsLoading: true));

    try {
      BaseResponse<UserResponse> response = await _userRepository.getUser();

      if (response.error != null || response.data == null) {
        return;
      }

      emit(state.copyWith(
        user: response.data!.user,
        userIsLoading: false,
      ));

      add(GetUserCategories());
    } catch (_) {
      emit(state.copyWith(userIsLoading: false));
    }
  }

  void _onGetUserCategories(GetUserCategories event, Emitter<HomeState> emit) async {
    emit(state.copyWith(categoriesIsLoading: true));

    try {
      BaseResponse<CategoriesResponse> response = await _userRepository.getCategories();

      if (response.error != null || response.data == null) {
        return;
      }

      emit(state.copyWith(
        categories: response.data!.categories,
        categoriesIsLoading: false,
      ));
    } catch (_) {
      emit(state.copyWith(categoriesIsLoading: false));
    }
  }

  void _onUploadFiles(UploadFiles event, Emitter<HomeState> emit) async {
    emit(state.copyWith(upload: true));

    try {
      await _userRepository.uploadFiles(event.files);
      emit(state.copyWith(upload: false));
      add(GetUserCategories());
    } catch (_) {
      emit(state.copyWith(upload: false));
    }
  }
}