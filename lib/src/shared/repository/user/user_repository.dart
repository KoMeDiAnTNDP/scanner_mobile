import 'package:scanner_mobile/src/shared/models/file.dart';
import 'package:scanner_mobile/src/shared/models/http/images_response.dart';
import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/service/http/http_service.dart';
import 'package:scanner_mobile/src/shared/repository/user/user_repository_interface.dart';

class UserRepository implements IUserRepository {
  final HttpService _httpService = HttpService();

  @override
  Future<BaseResponse<CategoriesResponse>> getCategories() async {
    BaseResponse<CategoriesResponse> response =
      await _httpService.makeRequest<CategoriesResponse>(HttpMethod.GET, '/user/categories');

    return response;
  }

  @override
  Future<BaseResponse<UserResponse>> getUser() async {
    BaseResponse<UserResponse> response =
      await _httpService.makeRequest<UserResponse>(HttpMethod.GET, '/user');

    return response;
  }

  @override
  Future<BaseResponse> uploadFiles(List<File> files) async {
    return await _httpService.makeRequest(
      HttpMethod.POST,
      '/documents/upload',
      files: files,
      isMultipart: true,
    );
  }

  @override
  Future<BaseResponse<ImagesResponse>> getImagesByCategory(int categoryId) async {
    Map<String, dynamic> params = {
      'category_id': categoryId,
    };

    return await _httpService.makeRequest(
      HttpMethod.GET,
      '/user/categories/images',
      params: params,
    );
  }
}