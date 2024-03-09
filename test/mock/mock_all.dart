import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MocksApplication {
  MockUser mockUser({String email = 'claudio@google.com.br', String name = 'Cláudio Marzo'}) {
    return MockUser(
      uid: 'testUid',
      email: 'claudio@google.com.br',
      displayName: name,
      photoURL: 'http://perfil.com/claudio-user.jpg',
      isEmailVerified: true,
      providerData: [],
      metadata: UserMetadata(DateTime.now().microsecondsSinceEpoch, DateTime.now().microsecondsSinceEpoch),
      isAnonymous: false,
    );
  }
}
