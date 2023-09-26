// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utilities/shared_preference_manager.dart';
import '../../models/user_model.dart';
import '../providers/user_providers.dart';

class AuthRepository {
  Future<bool> registerUser(
      {required String email,
      required String password,
      required String name}) async {
    final auth = FirebaseAuth.instance;
    try {
      User user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await SharedPreferencesManager().setLoggedIn(value: true);
        await SharedPreferencesManager().setId(value: user.uid);
        await SharedPreferencesManager().setName(value: name);
        await UserProviders().createUserData(
          user: UserModel(name, email, "phone", "github", "linkedin", "twitter",
              user.uid, "technology", "imageUrl"),
          id: user.uid,
        );
        debugPrint("Account created Succesfull");
        return true;
      } else {
        debugPrint("Account creation failed");
        return false;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    final auth = FirebaseAuth.instance;
    try {
      User user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await SharedPreferencesManager().setLoggedIn(value: true);
        await SharedPreferencesManager().setId(value: user.uid);
        await SharedPreferencesManager().setName(value: user.displayName ?? "");
        debugPrint("Login Succesfull");
        return true;
      } else {
        debugPrint("Login failed");
        return false;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> logoutUser() async {
    final auth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      await SharedPreferencesManager().setLoggedIn(value: false);
      debugPrint("Logout Succesfull");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
      debugPrint("Reset Password email sent Successfully");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final auth = FirebaseAuth.instance;
    try {
      debugPrint(oldPassword);
      debugPrint(newPassword);
      debugPrint(email);
      User user = auth.currentUser!;
      final credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      debugPrint("Change Password Succesfull");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> deleteUser(
      {required String email, required String password}) async {
    final auth = FirebaseAuth.instance;
    try {
      User user = auth.currentUser!;
      final credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
      await user.delete();
      debugPrint("Delete User Succesfull");
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      debugPrint("The google account is $googleSignInAccount");

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        print("The accessTOken is ${googleSignInAuthentication.accessToken}");
        print("The refreshToken is ${googleSignInAuthentication.idToken}");

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        debugPrint("The user is $userCredential");

        if (userCredential.user != null) {
          await SharedPreferencesManager().setAuthAccessToken(
              value: googleSignInAuthentication.accessToken!);
          await SharedPreferencesManager()
              .setAuthRefreshToken(value: googleSignInAuthentication.idToken!);
          await SharedPreferencesManager().setLoggedIn(value: true);
          await SharedPreferencesManager()
              .setName(value: userCredential.user!.displayName!);
          await SharedPreferencesManager()
              .setId(value: userCredential.user!.uid);
          debugPrint("Login Succesfull");
          return true;
        } else {
          await SharedPreferencesManager().setLoggedIn(value: true);
          await SharedPreferencesManager()
              .setId(value: userCredential.user!.uid);
          await SharedPreferencesManager()
              .setName(value: userCredential.user!.displayName!);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
