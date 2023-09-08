// import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mocktail/mocktail.dart';

// class MockUser extends Mock implements User {}
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// void main() {
//   setUpAll(() {
//     registerFallbackValue<User>(MockUser());
//   });

//   group('Firebase Auth', () {
//     late FirebaseAuth firebaseAuth;
//     late User user;

//     setUp(() {
//       firebaseAuth = MockFirebaseAuth();
//       user = MockUser();
//     });

//     test('sign in user', () async {
//       when(() => firebaseAuth.).thenAnswer((_) async => UserCredential(user: user));

//       expect(await firebaseAuth.signInAnonymously(), isA<UserCredential>());
//       verify(() => firebaseAuth.signInAnonymously()).called(1);
//     });
//   });
// }
