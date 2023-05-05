

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/widget/auth_text_from_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit_login/cubit.dart';
import '../cubit_login/states.dart';
import '../widget/auth_button.dart';
import '../widget/text_utils.dart';
import 'package:image_picker/image_picker.dart';

class AddNotes extends StatelessWidget {
   AddNotes({Key? key}) : super(key: key);
   File? myFile;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state)
        {
        if(state is ShopAddNotesSuccessState)  
          {
            shotToast(
              text: 'Save',
              state: ToastStates.SUCCESS,
            );
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
                      showModalBottomSheet(
                          context: context,
                          builder: (context)=> Container(
                            height: 100,
                            child: Column(
                              children:
                              [
                                InkWell(
                                  onTap:()async
                                  {
                                    XFile? xFile=await ImagePicker().pickImage(source: ImageSource.gallery);
                                     myFile=File(xFile!.path);
                                  },
                                  child:Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                   width: double.infinity,
                                   child: const Text(
                                       'From Gallery',
                                     style: TextStyle(
                                       fontSize: 16,
                                     ),
                                   ),

                                ),
                                ),
                                InkWell(
                                  onTap: ()
                                  async {
                                    XFile? xFile=await ImagePicker().pickImage(source: ImageSource.camera);
                                    myFile=File(xFile!.path);
                                  },
                                  child:Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      'From Camera',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ) ,
                      );
                    },
                    text: 'Choose Image',
                  ),
                  const SizedBox(height: 50,),
                  AuthButton(
                    onPressed: ()
                    {
                      if(formKey.currentState!.validate()) {
                        if (myFile != null) {
                          cubit.addNotes(
                            title: titleController.text,
                            content: contentController.text,
                            file: myFile!,
                          );
                        }
                        else
                          {
                            shotToast(
                              text: 'Choose Image',
                              state: ToastStates.WARNIG,
                            );
                          }
                      }
                    },
                    text: 'Save',
                  ),
                ],

              ),
            ),
          ),
        );
    });


  }
}
