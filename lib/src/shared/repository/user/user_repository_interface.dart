import 'package:scanner_mobile/src/shared/models/models.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';

abstract class IUserRepository {
  Future<BaseResponse<UserResponse>> getUser();
  Future<BaseResponse<CategoriesResponse>> getCategories();
  Future<BaseResponse> uploadFiles(List<File> files);
  Future<BaseResponse<ImagesResponse>> getImagesByCategory(int categoryId);
}