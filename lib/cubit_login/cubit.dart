

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit_login/states.dart';
import 'package:notes_app/model_screen/login_model/login_model.dart';
import 'package:notes_app/model_screen/view_model/view_notes.dart';
import '../model_screen/view_model/view_notes.dart';
import '../newtork/crud.dart';
import '../newtork/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(ShopAuthInitialState());

  static AppCubit get(contex) => BlocProvider.of(contex);
  bool isPasswordShow = true;
  LoginModel? loginModel;
  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    emit(ShopChangePasswordVisibilityState());
  }

  void singUp({
   required String name,
    required String email,
    required String password,
})
  {
    emit(ShopSingUpLoadingState());
    Crud.postRequest(
        url:'http://10.0.2.2:8080/corssphp/auth/singup.php?',
        data:
        {
          'usrname':name,
          'email':email,
          'password':password,
        }).then((value)
    {
      loginModel=LoginModel.fromJson(value);
      emit(ShopSingUpSuccessState(loginModel!));
    }).catchError((e){
      print(e.toString());
      emit(ShopSingUpErrorState(e));
    });
  }

  void login({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());
    Crud.postRequest(
        url:'http://10.0.2.2:8080/corssphp/auth/login.php',
        data:
        {
          'email':email,
          'password':password,
        }).then((value)
    {
        loginModel=LoginModel.fromJson(value);
       emit(ShopLoginSuccessState(loginModel!));
        getNotes();
    }).catchError((e){
      print(e.toString());
      emit(ShopLoginErrorState(e));
    });
  }

  getNotesModel? getNotesView;
  void getNotes()
  {
    emit(ShopGetNotesLoadingState());
    Crud.postRequest(
        url: 'http://10.0.2.2:8080/corssphp/auth/view.php?' ,
        data: {
          'id':CacheHelper.getBoolean(key: 'id'),
        }).then((value)
        {
          getNotesView=getNotesModel.fromJson(value);
          emit(ShopGetNotesSuccessState(getNotesView!));
          print('Successful');
        }).catchError((e)
        {
          print(e.toString());
          emit(ShopGetNotesErrorState(e.toString()));
        });
  }

  void addNotes({required String title,required String content, required File file})
  {
    emit(ShopAddNotesLoadingState());
    Crud.postRequestWithFile(
        url: 'http://10.0.2.2:8080/corssphp/auth/add.php',
        file: file,
        data:
        {
         'title':title,
          'content':content,
          'id':CacheHelper.getBoolean(key: 'id'),

        }).then((value)
        {
          emit(ShopAddNotesSuccessState());
          getNotes();
        }).catchError((e)
    {
      print(e.toString());
      emit(ShopAddNotesErrorState(e.toString()));
    });
  }

  void deleteNotes({required int id, required String image}) {
    emit(ShopDeleteNotesLoadingState());
    Crud.postRequest(
        url: 'http://10.0.2.2:8080/corssphp/auth/delete.php',
        data:
        {
          'id': id.toString(),
          'imagename':image.toString(),
        }).then((value) {
      emit(ShopDeleteNotesSuccessState());
      getNotes();
    }).catchError((e) {
      print(e.toString());
      emit(ShopDeleteNotesErrorState(e.toString()));
    });
  }

  void editNotes({required String title,required String content, required int id}) {
    emit(ShopEditNotesLoadingState());
    Crud.postRequest(
        url: 'http://10.0.2.2:8080/corssphp/auth/edit.php',
        data:
        {
          'title': title,
          'content': content,
          'id': id.toString(),
        }).then((value) {
      emit(ShopEditNotesSuccessState());
      getNotes();
    }).catchError((e) {
      print(e.toString());
      emit(ShopEditNotesErrorState(e.toString()));
    });


  }
}