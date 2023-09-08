part of 'admin_cubit.dart';

abstract class AdminState {}

class AdminInitial extends AdminState {}

class UserAdmin extends AdminState {
  final bool isAdmin;

  UserAdmin({required this.isAdmin});
}

class UserNotAdmin extends AdminState {
  final bool isAdmin;

  UserNotAdmin({required this.isAdmin});
}
