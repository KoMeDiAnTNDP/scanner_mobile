import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scanner_mobile/src/category/category.dart';

import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required Category mainCategory,
    required UserRepository userRepository,
    Category? subCategory,
  }): _mainCategory = mainCategory,
        _subCategory = subCategory,
        _userRepository = userRepository,
        super(const CategoryState()) {
    on<GetSubCategory>(_onGetSubCategories);
    on<GetImages>(_onGetImages);

    if (subCategory == null) {
      add(GetSubCategory(mainCategory.id));
    } else {
      add(GetImages(
        mainCategoryId: mainCategory.id,
        subCategoryId: subCategory.id,
      ));
    }
  }

  final Category _mainCategory;
  final Category? _subCategory;
  final UserRepository _userRepository;

  Category get mainCategory => _mainCategory;

  Category? get subCategory => _subCategory;

  void _onGetSubCategories(GetSubCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(subCategoriesLoading: true));

    try {
      BaseResponse<CategoriesResponse> response = await _userRepository.getCategories(
        mainCategoryId: event.mainCategoryId,
      );

      if (response.error != null || response.data == null) {
        emit(state.copyWith(subCategoriesLoading: false));

        return;
      }

      emit(state.copyWith(
        subCategories: response.data!.categories,
        subCategoriesLoading: false,
      ));
      add(GetImages(mainCategoryId: event.mainCategoryId));
    } catch (_) {
      emit(state.copyWith(subCategoriesLoading: false));
    }
  }

  void _onGetImages(GetImages event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(imagesLoading: true));

    try {
      BaseResponse<ImagesResponse> response =
        await _userRepository.getImagesByCategory(
          mainCategoryId: event.mainCategoryId,
          subCategoryId: event.subCategoryId,
        );

      if (response.error != null || response.data == null) {
        emit(state.copyWith(imagesLoading: false));

        return;
      }

      emit(state.copyWith(
        imageUrls: response.data!.imageUrls,
        imagesLoading: false,
      ));
    } catch (_) {
      emit(state.copyWith(imagesLoading: false));
    }
  }
}