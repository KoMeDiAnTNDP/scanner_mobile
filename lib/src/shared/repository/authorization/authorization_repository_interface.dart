import 'package:scanner_mobile/src/shared/models/http/models.dart';

abstract class IAuthorizationRepository {
  Future<BaseResponse<TokenResponse>> signIn(String email, String password);
  Future<BaseResponse<TokenResponse>> signUp(String email, String password, String username);
}
