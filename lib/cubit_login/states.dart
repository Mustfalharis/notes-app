
import 'package:notes_app/model_screen/view_model/view_notes.dart';

import '../model_screen/login_model/login_model.dart';

abstract class AppStates{}
class ShopAuthInitialState extends AppStates{}
class ShopSingUpLoadingState extends AppStates{}
class ShopSingUpSuccessState extends AppStates
{
  LoginModel loginModel;
  ShopSingUpSuccessState(this.loginModel);
}
class ShopSingUpErrorState extends AppStates
{
  final String error;
  ShopSingUpErrorState(this.error);
}
class ShopLoginLoadingState extends AppStates{}
class ShopLoginSuccessState extends AppStates
{
  LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends AppStates
{
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopGetNotesLoadingState extends AppStates{}
class ShopGetNotesSuccessState extends AppStates
{
  getNotesModel getNotes;
  ShopGetNotesSuccessState(this.getNotes);
}
class ShopGetNotesErrorState extends AppStates
{
  final String error;
  ShopGetNotesErrorState(this.error);
}

class ShopAddNotesLoadingState extends AppStates{}
class ShopAddNotesSuccessState extends AppStates {}
class ShopAddNotesErrorState extends AppStates
{
  final String error;
  ShopAddNotesErrorState(this.error);
}

class ShopEditNotesLoadingState extends AppStates{}
class ShopEditNotesSuccessState extends AppStates {}
class ShopEditNotesErrorState extends AppStates
{
  final String error;
  ShopEditNotesErrorState(this.error);
}

class ShopDeleteNotesLoadingState extends AppStates{}
class ShopDeleteNotesSuccessState extends AppStates {}
class ShopDeleteNotesErrorState extends AppStates
{
  final String error;
  ShopDeleteNotesErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends AppStates{}
