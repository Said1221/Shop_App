import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category_datails.dart';
import 'package:shop_app/category_products.dart';
import 'package:shop_app/constant/dio_helper.dart';
import 'package:shop_app/constant/shared_pref.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/favorite.dart';
import 'package:shop_app/home_layout.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/onBoarding.dart';
import 'package:shop_app/setting.dart';
import 'package:shop_app/state.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  print(CacheHelper.getData(key: 'token'));
  await dioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          return MaterialApp(
            theme: ThemeData(
            ),
            home: onBoarding(),
            debugShowCheckedModeBanner: false,
          );
          },
      ),
    );
  }
}

