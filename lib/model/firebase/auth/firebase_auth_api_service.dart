import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthApiService {
  final _fireBaseAuth = FirebaseAuth.instance;

  Future<AuthResult> signIn(String email, String password) async {
    return _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> signUp(String email, String password) async {
    return _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleCurrentUser = _googleSignIn.currentUser;
    try {
      if (googleCurrentUser == null)
        googleCurrentUser = await _googleSignIn.signInSilently();
      if (googleCurrentUser == null)
        googleCurrentUser = await _googleSignIn.signIn();
      if (googleCurrentUser == null) return null;

      GoogleSignInAuthentication googleAuth =
          await googleCurrentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final AuthResult result =
          (await _fireBaseAuth.signInWithCredential(credential));
      print("signed in " + result.user.displayName);

      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthResult> signInWithApple() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(
        requestedScopes: [Scope.fullName],
        requestedOperation: OpenIdOperation.operationLogin,
      )
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        const oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(result.credential.identityToken),
          accessToken:
              String.fromCharCodes(result.credential.authorizationCode),
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
        break;
      case AuthorizationStatus.error:
        PlatformException(
            code: '1000', message: 'error', details: result.error.toString());
        return null;
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        return null;
        break;
      default:
        return null;
        break;
    }
  }
}
