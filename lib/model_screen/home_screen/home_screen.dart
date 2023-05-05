


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/model_screen/add_notes.dart';
import 'package:notes_app/model_screen/edit_notes.dart';
import 'package:notes_app/model_screen/home_screen/cart_screen.dart';
import 'package:notes_app/model_screen/login_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:notes_app/model_screen/singup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit_login/cubit.dart';
import '../../cubit_login/states.dart';
import '../../newtork/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
    builder: (context, state)
    {
    var cubit=AppCubit.get(context);
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('home'),
        actions:
        [
          IconButton(
            onPressed: ()
            {
              CacheHelper.removeData(key: "id");
              CacheHelper.removeData(key: "username");
              CacheHelper.removeData(key: "email");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext) {
                  return SingUpScreen();
                }
                ),
                    (route) {
                  return false;
                },
              );
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
            return AddNotes();}));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body:Container(
        height: 600,
        padding:  EdgeInsets.all(10),
        child: ConditionalBuilder(
          condition: state is ShopGetNotesSuccessState && cubit.getNotesView!.data!=null,
          builder: (context) =>ListView.separated(
            itemBuilder: (context,index)
            {
              return  CartScreen(
                title: '${cubit.getNotesView!.data![index].notesTitle}',
                content: '${cubit.getNotesView!.data![index].notesContent}',
                 image: '${cubit.getNotesView!.data![index].notesImage}',
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                    return EditNotes(
                      image: cubit.getNotesView!.data![index].notesImage.toString(),
                      title:cubit.getNotesView!.data![index].notesTitle.toString(),
                      content:cubit.getNotesView!.data![index].notesContent.toString(),
                      id:int.parse(cubit.getNotesView!.data![index].notesId,
                      ),
                    );}));
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
            itemCount:cubit.getNotesView!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        ),




      ),



    );
    }
    );


  }
}
