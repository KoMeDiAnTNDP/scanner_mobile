import 'package:scanner_mobile/src/shared/models/http/models.dart';
import 'package:scanner_mobile/src/shared/service/http/http_service.dart';
import 'package:scanner_mobile/src/shared/repository/authorization/authorization_repository_interface.dart';

class AuthorizationRepository implements IAuthorizationRepository{
  final HttpService _httpService = HttpService();

  @override
  Future<BaseResponse<TokenResponse>> signIn(String email, String password) async {
    Map<String, String> body = {
      'email': email,
      'password': password
    };

    BaseResponse<TokenResponse> response = await _httpService.makeRequest<TokenResponse>(
      HttpMethod.POST,
      '/login',
      body: body,
    );

    return response;
  }

  @override
  Future<BaseResponse<TokenResponse>> signUp(String email, String password, String username) async {
    Map<String, String> body = {
      'email': email,
      'username': username,
      'password': password,
    };

    BaseResponse<TokenResponse> response = await _httpService.makeRequest(
      HttpMethod.POST,
      '/register',
      body: body,
    );

    return response;
  }
}
