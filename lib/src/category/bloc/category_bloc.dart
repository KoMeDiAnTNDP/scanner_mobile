import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required Category category,
    required UserRepository userRepository,
  }): _category = category,
        _userRepository = userRepository,
        super(const CategoryState()) {
    on<UploadImages>(_onUploadImages);

    add(UploadImages());
  }

  final Category _category;
  final UserRepository _userRepository;

  Category get category => _category;

  void _onUploadImages(UploadImages event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(loading: true));

    try {
      BaseResponse<ImagesResponse> response =
        await _userRepository.getImagesByCategory(_category.id);

      if (response.error != null || response.data == null) {
        emit(state.copyWith(loading: false));

        return;
      }

      emit(state.copyWith(
        imageUrls: response.data!.imageUrls,
        loading: false,
      ));
    } catch (_) {
      emit(state.copyWith(loading: false));
    }
  }
}