import 'dart:async';

import 'package:meta/meta.dart';

enum AuthenticationStatus { unknow, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn(
      {@required String username, @required String password}) async {
    assert(username != null);
    assert(password != null);

    await Future.delayed(Duration(milliseconds: 300),
        () => _controller.add(AuthenticationStatus.authenticated));
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}