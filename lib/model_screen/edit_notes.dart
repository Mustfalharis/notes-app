
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/model_screen/home_screen/home_screen.dart';

import '../cubit_login/cubit.dart';
import '../cubit_login/states.dart';
import '../widget/auth_button.dart';
import '../widget/auth_text_from_field.dart';
import '../widget/text_utils.dart';
class EditNotes extends StatelessWidget {
    EditNotes({
          required this.title,
          required this.content,
          required this.id,
          required this.image,
    }) ;
    final String title;
    final String content;
    final int id;
    final String image;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    titleController.text=title;
    contentController.text=content;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)
        {
          if(state is ShopEditNotesSuccessState)
            {
              shotToast(
                  text: 'Edit',
                  state: ToastStates.SUCCESS,
              );
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                return HomeScreen();}));
            }
          if(state is ShopDeleteNotesSuccessState)
            {
              shotToast(
                text: 'delete',
                state: ToastStates.SUCCESS,
              );
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                return HomeScreen();}));
            }
        },
        builder: (context, state)
        {
          var cubit=AppCubit.get(context);

          return  Scaffold(
            appBar: AppBar(
              title: const Text('add Notes'),
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: ListView(
                  children:
                  [
                    const SizedBox(height: 100,),
                    AuthTextFromField(
                      controller: titleController,
                      obscureText: false,
                      hintText: 'Title',
                      validator:  (var value)
                      {
                        if(value.isEmpty)
                        {
                          return 'is Not Emptay';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25,),
                    AuthTextFromField(
                      controller: contentController,
                      obscureText: false,
                      hintText: 'content',
                      validator:  (var value)
                      {
                        if(value.isEmpty)
                        {
                          return 'is Not Emptay';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50,),
                    AuthButton(
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          print(id.toString());
                          cubit.editNotes(
                            title: titleController.text ,
                            content: contentController.text,
                             id: id
                        );
                        }
                      },
                      text: 'Edit',
                    ),
                    const SizedBox(height: 25,),
                    AuthButton(
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                         cubit.deleteNotes(id: id,image: image);
                        }
                      },
                      text: 'Delete',
                    ),
                  ],

                ),
              ),
            ),
          );
        });

  }
}
