// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../mock/mock_all.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// class MockUserCredential extends Mock implements UserCredential {}

// main() {
//   group('firebase_service_test', () {
//     test('Teste de criação de usuário com sucesso', () async {
//       final mockApplication = MocksApplication();
//       final firebaseAuth = MockFirebaseAuth();
//       final MockUserCredential userCredential = MockUserCredential();
//       late String email = 'claudio@google.com.br';
//       late String password = "teste01";

//       when(firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       )).thenAnswer((_) async => user);

//       final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

//       // Verifica se o resultado é o esperado
//       expect(result, isNotNull);
//       expect(result.user, isNotNull);
//       expect(result.user!.email, equals('claudio@google.com.br'));
//     });
//     test('Validating createUserWithEmailAndPassword method', () async {
//       //Arrange

//       //Act

//       //Assert
//     });
//     test('Validating signInWithEmailAndPassword method', () async {
//       //Arrange

//       //Act

//       //Assert
//     });
//   });
// }
