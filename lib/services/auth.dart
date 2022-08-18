import 'package:firebase_auth/firebase_auth.dart';
import 'package:memental/model/user.dart';
import 'package:memental/services/database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(
      String email,
      String password,
      String name,
      String role,
      String number,
      String age,
      String speciality,
      bool isActivated,
      String uid) {
    return UserModel(
        email: email,
        password: password,
        name: name,
        role: role,
        speciality: speciality,
        age: age,
        number: number,
        isActivated: isActivated,
        uid: uid);
  }

  Future<UserModel?> _userStreamToUserModel(User? user) async {
    return user != null ? DatabaseService().getUserData(user.uid) : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap(_userStreamToUserModel);
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Sign in done at UID ${result.user!.uid.toString()}');
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password, String name, String role,
      String number, String age, String speciality, bool isActivated) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = result.user!.uid.toString();
      DatabaseService().updateUserData(uid, password, name, role, number, age,
          speciality, email, isActivated);

      return result.user != null
          ? _userFromFirebaseUser(email, password, name, role, number, age,
              speciality, isActivated, result.user!.uid)
          : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
