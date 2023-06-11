import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:multi_store_app/features/auth/data/mappers/auth_mappers.dart';
import 'package:multi_store_app/features/auth/data/models/auth_model.dart';
import 'package:multi_store_app/features/auth/domain/source/auth/auth_datasource.dart';
import 'package:multi_store_app/features/providers/auth/global_auth/global_auth_provider.dart';

class FirebaseAuthDataSource extends AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuthDataSource(this.firebaseAuth);

  @override
  userLogOut() async {
    await firebaseAuth.signOut();
  }

  @override
  userLogin(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final userModel = await getUserModel();
      return userModel;
    } on FirebaseAuthException catch (_) {
      firebaseAuth.signOut();
      rethrow;
    } on FirebaseException catch (_) {
      firebaseAuth.signOut();
      rethrow;
    }
  }

  @override
  userSignIn(String email, String password, String name, String lastName) async {
    try {
      final userAuth = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      try {
        await firestore.collection('users').doc("${userAuth.user?.uid}").set({
          "email": email,
          "name": name,
          "lastName": lastName,
          "uid": userAuth.user?.uid,
          "roles": ['customer']
        });
      } on FirebaseException catch (_) {
        rethrow;
      }
      return UserModel(
          email: email,
          lastName: lastName,
          name: name,
          roles: ['customer'],
          token: userAuth.user?.uid,
          userId: userAuth.user?.uid);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  @override
  checkUserStatus() async {
    if (firebaseAuth.currentUser == null) {
      return AuthStatus.notAuthenticated;
    } else {
      try {
        await firestore.collection('users').doc("${firebaseAuth.currentUser?.uid}").get();
        return AuthStatus.authenticated;
      } on FirebaseException catch (_) {
        return AuthStatus.authenticated;
      }
    }
  }

  @override
  Future<UserModel> getUserModel() async {
    bool userDataRetrieved = false;
    int retryCount = 0;
    while (retryCount < 2 && !userDataRetrieved) {
      try {
        final userData = await firestore.collection('users').doc("${firebaseAuth.currentUser?.uid}").get();
        final mappedUser = AuthMappers.firebaseUserJsonToEntity(userData.data() ?? {});

        userDataRetrieved = true;
        return mappedUser;
      } catch (e) {
        retryCount++;
      }
    }

    throw Exception();
  }

  @override
  Future<void> sendRecoveryPasswordEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> changeUserPassword(String token) async {
    try {} catch (_) {}
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential credentials = await FirebaseAuth.instance.signInWithCredential(credential);
      try {
        final userData = await getUserModel();
        return userData;
      } catch (e) {
        try {
          await firestore.collection('users').doc("${credentials.user?.uid}").set({
            "email": credentials.user?.email,
            "name": credentials.user?.displayName,
            "lastName": '',
            "uid": credentials.user?.uid,
            "roles": ['customer']
          });
          return UserModel(
              name: credentials.user?.displayName,
              email: credentials.user?.email,
              userId: credentials.user?.uid,
              lastName: '',
              roles: ['customer']);
        } on FirebaseException catch (_) {
          rethrow;
        }
      }
      //-----------------
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');
      final UserCredential credentials = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      try {
        final userData = await getUserModel();
        return userData;
      } catch (e) {
        try {
          await firestore.collection('users').doc("${credentials.user?.uid}").set({
            "email": credentials.user?.email,
            "name": credentials.user?.displayName,
            "lastName": '',
            "uid": credentials.user?.uid,
            "roles": ['customer']
          });
          return UserModel(
              name: credentials.user?.displayName,
              email: credentials.user?.email,
              userId: credentials.user?.uid,
              lastName: '',
              roles: ['customer']);
        } on FirebaseException catch (_) {
          rethrow;
        }
      }
    } catch (_) {
      rethrow;
    }
  }
}
