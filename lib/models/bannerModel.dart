import 'package:flutter/material.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/models/bannerModel.dart';


class bannerModel{
  bool status;
  String message;
  bannerData data;

  bannerModel.fromJson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
    data = bannerData.fromJson(json[AppCubit().data]);
  }
}

class bannerData{
  int id;
  String image;
  String category;
  String product;

  bannerData({
    this.id,
    this.image,
    this.category,
    this.product,
});

  bannerData.fromJson(List<dynamic>json){
    // id = json['id'];
    // image = json['image'];
    // category = json['category'];
    // product = json['product'];
  }
}