
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/my_clipper.dart';
import 'package:shop_app/constant/shared_pref.dart';
import 'package:shop_app/cubit.dart';

import 'package:shop_app/login/cubit.dart';
import 'package:shop_app/login/state.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/onBoarding.dart';
import 'package:shop_app/state.dart';

class setting_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext)=>AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit , AppLoginState>(
        listener: (BuildContext context , AppLoginState state){},
          builder: (BuildContext context , AppLoginState state){
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  ClipPath(
                    clipper: MyClipperr(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF3383CD),
                            Color(0xFF11249F),
                          ],
                        ),
                      ),
                    ),
                  ),

                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeNE3bp-sVJRsVDvT24bExO9Ycd7F_kq6YshV1Fa9yWoaJfL9DzUAoaBDNkHPvdV2h6fA&usqp=CAU'),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Name :' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(CacheHelper.getData(key: 'name'), style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Email :' ,  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(CacheHelper.getData(key: 'email') , style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(
                        width: 5,
                      ),
                      Text('phone :' ,  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(CacheHelper.getData(key: 'phone') , style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [
                                Colors.red[200],
                                Colors.red,
                                Colors.red[200]
                              ]
                          )
                      ),

                      width: double.infinity,
                      child: MaterialButton(onPressed: (){
                        showDialog(context: context,
                            builder: (BuildContext context)=>AlertDialog(
                              title: Text('Are you sure you want logout!!' , style: TextStyle(fontWeight: FontWeight.bold),),
                              content: Text('You will be returned to boarding screen' , style: TextStyle(color: Colors.grey),),
                              actions: [
                                TextButton(onPressed: (){
                                  cubit.logOut(CacheHelper.getData(key: 'token'));
                                    navigateTo(context, onBoarding());
                                },
                                  child: Text('ok'),
                                ),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                  child: Text('cancel'),
                                ),
                              ],
                            ),
                        );
                      },
                        child: Text('Logout'),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
          },
      ),
    );
  }
}
