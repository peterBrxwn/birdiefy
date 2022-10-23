import 'package:birdiefy/routing/guard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:birdiefy/routing/router.gr.dart';
import 'package:birdiefy/services/firebase.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @injectable
  FirebaseFirestore get store => FirebaseFirestore.instance;

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;

  @injectable
  AppRouter get appRouter => AppRouter(authGuard: AuthGuard());
}
