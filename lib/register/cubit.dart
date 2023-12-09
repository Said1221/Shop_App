
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
import 'package:shop_app/register/state.dart';
import 'package:shop_app/setting.dart';
import 'package:shop_app/state.dart';

class AppRegCubit extends Cubit<AppRegState>{
  AppRegCubit() : super (AppRegInitialState());

  static AppRegCubit get(context)=>BlocProvider.of(context);


  void regUser({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
}){
    emit(AppRegLoadingState());
    dioHelper.postNewData(
        url: 'register',
      data: {
          'name' : name,
          'email' : email,
          'phone' : phone,
          'password' : password,
      }
    ).then((value){
      if(value.data['data'] != null){
        message = value.data['message'];
        emit(AppRegSuccessState());
      }
      else{
        message = value.data['message'];
        emit(AppRegErrorState());
      }
    });
  }

}