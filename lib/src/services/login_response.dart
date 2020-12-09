import 'package:login_app/src/models/user.dart';

import 'login_request.dart';

abstract class LoginCallBack {
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginResponse {
  LoginCallBack _callBack;
  LoginRequest loginRequest = new LoginRequest();
  LoginResponse(this._callBack);

  doLogin(String usuario, String senha) {
    loginRequest
        .getLogin(usuario, senha)
        .then((user) => _callBack.onLoginSuccess(user))
        .catchError((e) => _callBack.onLoginError(e.toString()));
  }
}
