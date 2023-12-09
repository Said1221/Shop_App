
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/dio_helper.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/favorite.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/login/state.dart';
import 'package:shop_app/models/bannerModel.dart';
import 'package:shop_app/setting.dart';
import 'package:shop_app/state.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super (AppinitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  bannerModel bannermodel;

  int currentIndex = 0;

  List<Widget>Screens = [
    home_screen(),
    category_screen(),
    favorite_screen(),
    setting_screen(),
  ];

  List<String>title = [
    'Home',
    'Category',
    'Favorite',
    'Profile'
  ];

  void onTapItem(int index){
    currentIndex = index;
    emit(AppChangeItem());
  }


  List<dynamic> data = [];
  void homeBanner(){
    dioHelper.getBanner(
      url:'banners',
    ).then((value){
      data = value.data['data'];
      emit(AppGetBannerSuccessState());
    }).catchError((error){
      emit(AppGetBannerErrorState());
      print(error.toString());
    });
  }


  List<dynamic> category = [];
  void getCategory(){
    dioHelper.getCategory(
      url:'categories',
    ).then((value){
      category = value.data['data']['data'];
      emit(AppGetCategorySuccessState());
    }).catchError((error){
      emit(AppGetCategoryErrorState());
      print(error.toString());
    });
  }



  List<dynamic> categoryProducts = [];
  void getCategoryProducts(){
    categoryProducts = [];
    dioHelper.getCategoryProducts(
      url:'products',
      query: {
        'category_id' : detId,
      }
    ).then((value){
      print(detId);
      categoryProducts = value.data['data']['data'];
      emit(AppGetCategoryProductsSuccessState());
    }).catchError((error){
      emit(AppGetCategoryProductsErrorState());
      print(error.toString());
    });
  }




  List<dynamic> products = [];
  void getProducts(){
    dioHelper.getProducts(
      url:'products',
      query: {
        'category_id' : ''
      }
    ).then((value){

      products = value.data['data']['data'];

      products.forEach((element){
        favorite.addAll({
          element['id'] : element['in_favorites']
        });
      });

      products.forEach((element){
        cart.addAll({
          element['id'] : element['in_cart']
        });
      });

      emit(AppGetProductsSuccessState());
    }).catchError((error){
      emit(AppGetProductsErrorState());
      print(error.toString());
    });
  }



  List<dynamic> favorites = [];
  void postFav(int id){

    favorite[id] = !favorite[id];

    dioHelper.postFav(
        url: 'favorites',
      data: {
          'product_id' : id,
      }
    ).then((value){

      emit(AppPostFavoritesSuccessState());
      getFav();


    }).catchError((error){
      print(error.toString());
      emit(AppPostFavoritesErrorState());
    });
  }

  void getFav(){



    dioHelper.getFav(
        url: 'favorites'
    ).then((value){
      favorites = value.data['data']['data'];

      emit(AppGetFavoritesSuccessState());

      // emit(AppGetCategoryProductsSuccessState());



    }).catchError((error){
      emit(AppGetFavoritesErrorState());
      print(error.toString());
    });
  }
  void deleteFav(int id){

    favorite[id] = !favorite[id];

    dioHelper.postFav(
        url: 'favorites',
        data: {
          'product_id' : id,
        }
    ).then((value){

      if(value.data['status'] == true){
        emit(AppDeleteFavoritesSuccessState());
      }

      else{
        emit(AppDeleteFavoritesErrorState());
      }



    });
  }





  List<dynamic> carts = [];
  void postCart(int id){

    cart[id] = !cart[id];

    dioHelper.postCart(
        url: 'carts',
        data: {
          'product_id' : id,
        }
    ).then((value){
      getCart();
      emit(AppPostCartSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPostCartErrorState());
    });
  }
  void getCart(){
    dioHelper.getCart(
        url: 'carts'
    ).then((value){
      carts = value.data['data']['cart_items'];
      emit(AppGetCartSuccessState());
    }).catchError((error){
      emit(AppGetCartErrorState());
      print(error.toString());
    });
  }



  List<dynamic> search = [];
  void postSearch(String text){
    search = [];
    dioHelper.postSearch(
        url: 'products/search',
      data: {
          'text' : text,
      }
    ).then((value){

      search = value.data['data']['data'];
      emit(AppPostSearchSuccessState());
    }).catchError((error){
      emit(AppPostSearchErrorState());
      print(error.toString());
    });
  }


  void logOut(token){
    dioHelper.logOut(
      url: 'logout',
      data: {
        'fcm_token' : token
      }
    ).then((value){
      if(value.data['status'] == true){
        emit(AppLogoutSuccessState());
      }
      else{
        emit(AppLogoutErrorState());
      }

    }).catchError((error){
      emit(AppLogoutErrorState());
    });
  }


}