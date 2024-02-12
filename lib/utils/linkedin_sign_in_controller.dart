import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkedin_login/linkedin_login.dart';

class LinkedinSignInController {
  final String clientId = '77s1py5qm1en4l';
  final String clientSecret = 'APX4Ny9hs7tvEwnf';
  final redirectUrl =
      'https://pharmashots.com/api/pharmashots/social/login/register';
  Future<UserSucceededAction?> handleLinkedinAuth(BuildContext context) async {
    UserSucceededAction? linkedInUser;
    //
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (final BuildContext context) => LinkedInUserWidget(
          redirectUrl: redirectUrl,
          clientId: clientId,
          clientSecret: clientSecret,
          onGetUserProfile: (user) {
            linkedInUser = user;
            print(linkedInUser?.user.userId);
            print(
                'Access token ${linkedInUser?.user.token.accessToken.toString()}');
            print(
                'First name: ${linkedInUser?.user.firstName!.localized!.label}');
            print(
                'Last name: ${linkedInUser?.user.lastName!.localized!.label}');

            Navigator.of(context).pop();
          },
          destroySession: true,
          projection: const [
            ProjectionParameters.id,
            ProjectionParameters.localizedFirstName,
            ProjectionParameters.localizedLastName,
            ProjectionParameters.firstName,
            ProjectionParameters.lastName,
            ProjectionParameters.profilePicture,
          ],
          onError: (UserFailedAction e) {
            Fluttertoast.showToast(msg: 'an error occurred');
            Navigator.of(context).pop();
            print('Error: ${e.toString()}');
            // Navigator.pop(context);
          },
        ),
      ),
    );
    return linkedInUser;
  }
}
//       tLtd_R89%)$9k5g