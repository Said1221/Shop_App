
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/dio_helper.dart';
import 'package:shop_app/constant/shared_pref.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/favorite.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/login/state.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/setting.dart';
import 'package:shop_app/state.dart';

class AppLoginCubit extends Cubit<AppLoginState>{
  AppLoginCubit() : super (AppLoginInitialState());

  static AppLoginCubit get(context)=>BlocProvider.of(context);

  loginModel model;

  void loginUser(String email ,String password){
    emit(AppLoginLoadingState());
    dioHelper.postData(
        url:'login',
      data: {
          'email' : email,
          'password' : password,
      },
    ).then((value){

      if(value.data['data'] != null){
        message = value.data['message'];
        model = loginModel.fromJson(value.data);
        CacheHelper.saveData(key: 'name', value: model.data.name);
        CacheHelper.saveData(key: 'email', value: model.data.email);
        CacheHelper.saveData(key: 'phone', value: model.data.phone);
        CacheHelper.saveData(key: 'token', value: model.data.token);
        print(CacheHelper.getData(key: 'token'));
        emit(AppLoginSuccessState());
      }

      else{
        message = value.data['message'];
        emit(AppLoginErrorState());
      }

    });
  }

}