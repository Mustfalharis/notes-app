import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/widget/bloc_Provider_class.dart';
import 'cubit_login/cubit.dart';
import 'cubit_login/states.dart';
import 'model_screen/home_screen/home_screen.dart';
import 'model_screen/singup_screen.dart';
import 'newtork/dio_helper.dart';
import 'newtork/local/cache_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer =  MyBlocObserver();
  await CacheHelper.init();
   Widget widget=SingUpScreen();
   var id=CacheHelper.getBoolean(key: "id");
   if(id!=null)
     {
       widget=HomeScreen();
     }
  runApp(MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
    Widget? widget;
     MyApp({ this.widget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context) => AppCubit()..getNotes()),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return  MaterialApp(
                home: widget,
              );
            }
        ),
    );
  }
}

