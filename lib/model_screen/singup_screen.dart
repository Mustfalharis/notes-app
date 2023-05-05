

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/widget/auth_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/widget/text_utils.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../cubit_login/cubit.dart';
import '../cubit_login/states.dart';
import '../newtork/local/cache_helper.dart';
import '../widget/auth_text_from_field.dart';
import 'home_screen/home_screen.dart';

import 'login_screen.dart';

class SingUpScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)
        {
          if(state is ShopSingUpSuccessState)
            {

              CacheHelper.saveData(key: "id",value: state.loginModel.data!.id.toString());
              CacheHelper.saveData(key: "username",value: state.loginModel.data!.email);
              CacheHelper.saveData(key: "email",value: state.loginModel.data!.password);
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>  HomeScreen(),
                ),
                    (Route<dynamic> route) => false,
              );
              shotToast(
                text: 'Sing UP',
                state: ToastStates.SUCCESS,
              );
            }
          else
            {
              shotToast(
                text: 'ERROR',
                state: ToastStates.ERROR,
              );
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
                  const SizedBox(height: 30,),
                  AuthTextFromField(
                    validator: (var value)
                    {
                      if(value.isEmpty)
                        {
                          return 'is Not Empay';
                        }
                      return null;
                    },
                    controller: userNameController,
                    obscureText: false,
                    hintText: 'User Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 20,),
                  AuthTextFromField(
                    validator: (var value)
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
                    validator: (var value)
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
                          cubit.singUp(
                              name: userNameController.text,
                              email: emailController.text,
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
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                         return LoginScreen();}));

                     },
                     child: TextUtils(
                         text: 'login',
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

