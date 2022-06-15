import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';

abstract class IUserRepository {
  Future<BaseResponse<UserResponse>> getUser();
  Future<BaseResponse<CategoriesResponse>> getCategories({int? mainCategoryId});
  Future<BaseResponse> uploadFiles(List<File> files, {bool advance = false});
  Future<BaseResponse<ImagesResponse>> getImagesByCategory({
    required int mainCategoryId,
    int? subCategoryId
  });
}