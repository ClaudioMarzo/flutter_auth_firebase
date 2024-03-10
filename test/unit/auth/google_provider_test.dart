// import 'package:flutter_test/flutter_test.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mockito/mockito.dart';

// class MockGoogleSignIn extends Mock implements GoogleSignIn {}

// void main() {
//   late MockGoogleSignIn googleSignIn;
//   setUp(() {
//     googleSignIn = MockGoogleSignIn();
//   });
//   group('google_auth_test', () {
//     test('should return idToken and accessToken when authenticating', () async {
//       final signInAccount = await googleSignIn.signIn();
//       final signInAuthentication = await signInAccount!.authentication;
//       expect(signInAuthentication, isNotNull);
//       expect(googleSignIn.currentUser, isNotNull);
//       expect(signInAuthentication.accessToken, isNotNull);
//       expect(signInAuthentication.idToken, isNotNull);
//     });

//     test('should return null when login is canceled by the user', () async {
//       googleSignIn.isSignedIn();
//       final signInAccount = await googleSignIn.signIn();
//       expect(signInAccount, isNull);
//     });
//     test('testing google login twice, once cancelled, once not cancelled at the same test.', () async {
//       googleSignIn.setIsCancelled(true);
//       final signInAccount = await googleSignIn.signIn();
//       expect(signInAccount, isNull);
//       googleSignIn.setIsCancelled(false);
//       final signInAccountSecondAttempt = await googleSignIn.signIn();
//       expect(signInAccountSecondAttempt, isNotNull);
//     });
//   });
// }
