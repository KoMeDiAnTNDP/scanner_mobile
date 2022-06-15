import 'package:scanner_mobile/src/shared/models/file.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/service/http/http_service.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  final HttpService _httpService = HttpService();

  @override
  Future<BaseResponse<CategoriesResponse>> getCategories({
    int? mainCategoryId,
  }) async {
    Map<String, dynamic>? params = mainCategoryId != null ? {
      'main_category_id': mainCategoryId,
    } : null;
    BaseResponse<CategoriesResponse> response =
      await _httpService.makeRequest<CategoriesResponse>(
        HttpMethod.GET,
        '/user/categories',
        params: params,
      );

    return response;
  }

  @override
  Future<BaseResponse<UserResponse>> getUser() async {
    BaseResponse<UserResponse> response =
      await _httpService.makeRequest<UserResponse>(HttpMethod.GET, '/user');

    return response;
  }

  @override
  Future<BaseResponse> uploadFiles(List<File> files, {bool advance = false}) async {
    return await _httpService.makeRequest(
      HttpMethod.POST,
      '/documents/upload',
      files: files,
      advance: advance,
      isMultipart: true,
    );
  }

  @override
  Future<BaseResponse<ImagesResponse>> getImagesByCategory({
    required int mainCategoryId,
    int? subCategoryId,
  }) async {
    Map<String, dynamic> params = {
      'main_category_id': mainCategoryId,
    };

    if (subCategoryId != null) {
      params['sub_category_id'] = subCategoryId;
    }

    return await _httpService.makeRequest(
      HttpMethod.GET,
      '/user/categories/images',
      params: params,
    );
  }
}