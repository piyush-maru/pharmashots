import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
  );

  ///should be used when needed to sign out of google account
  Future<GoogleSignInAccount?> handleSignOutGoogle() async {
    return await _googleSignIn.signOut();
  }

// linked in
  Future<User?> handleGoogleAuth() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();

    User? user;
    try {
      await handleSignOutGoogle();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        print(
            "access token:\n\n${googleSignInAuthentication.accessToken}\n\n\n");
        // Getting users credential
        // try {
        UserCredential result = await auth.signInWithCredential(authCredential);
        user = result.user;

        if (result.user != null) {
          print("google sign up success: details of user:");
          print(await user!.getIdToken());
        } else {
          print("sign up failed with an error ");
        }
        // } catch (e) {
        //   print(e.toString());
        // }
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}
