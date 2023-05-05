

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/model_screen/home_screen/home_screen.dart';
import 'package:notes_app/model_screen/singup_screen.dart';
import 'package:notes_app/widget/auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/widget/text_utils.dart';
import '../cubit_login/cubit.dart';
import '../cubit_login/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../newtork/local/cache_helper.dart';
import '../widget/auth_text_from_field.dart';
import 'login_screen.dart';
import '../cubit_login/cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status=="success")
            {
              {
                shotToast(
                  text: state.loginModel.status!,
                  state: ToastStates.SUCCESS,
                );
                CacheHelper.saveData(key: "id",value: state.loginModel.data!.id.toString());
                CacheHelper.saveData(key: "username",value: state.loginModel.data!.usrname);
                CacheHelper.saveData(key: "email",value: state.loginModel.data!.email);
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>  HomeScreen(),
                  ),
                      (Route<dynamic> route) => false,
                );
              }
            }
          }
        },
        builder: (context, state)
        {
          var cubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children:
                    [
                      Image.asset(
                        "assets/images/notes.png",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 20,),
                      AuthTextFromField(
                        validator:  (var value)
                        {
                          if(value.isEmpty)
                          {
                            return 'is Not Empay';
                          }
                          return null;
                        },
                        controller: emailController,
                        obscureText: false,
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 20,),
                      AuthTextFromField(
                        validator:  (var value)
                        {
                          if(value.isEmpty)
                          {
                            return 'is Not Empay';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: cubit.isPasswordShow,
                        hintText: 'password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: ConditionalBuilder(
                          condition: cubit.isPasswordShow==false,
                          builder: (context)=>IconButton(
                            onPressed: ()
                            {
                              cubit.changePasswordVisibility();
                            },
                            icon: const Icon(Icons.visibility),
                          ),
                          fallback:(context)=>IconButton(
                            onPressed: ()
                            {
                              cubit.changePasswordVisibility();
                            },
                            icon: const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      AuthButton(
                        onPressed: ()
                        {
                          if(formKey.currentState!.validate())
                            {
                              cubit.login(
                                  email: emailController.text ,
                                  password: passwordController.text,
                              );
                            }
                        },
                        text: 'SING UP',
                      ),
                      const  SizedBox(height: 10),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.pop(context);

                        },
                        child: TextUtils(
                          text: 'singUp',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
