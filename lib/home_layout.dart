
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/cart.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/search.dart';
import 'package:shop_app/state.dart';

class home_layout extends StatefulWidget {


  @override
  State<home_layout> createState() => _home_layoutState();
}

class _home_layoutState extends State<home_layout> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getCart(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){
        },
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              titleSpacing: 7,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(cubit.title[cubit.currentIndex] , style: TextStyle(color: Colors.black),),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, search_screen());
                },
                    icon: Icon(Icons.search , size: 30,),
                  color: Colors.black,
                ),


                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: IconButton(onPressed: (){
                        navigateTo(context, cart_screen());
                      },
                        icon: Icon(Icons.shopping_cart_outlined , size: 30,),
                        color: Colors.black,
                      ),
                    ),

                    // Text('${num.toString()}' , style: TextStyle(color: Colors.teal , fontWeight: FontWeight.bold , fontSize: 20)),
                  ],
                ),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],

            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40) , topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40) , topRight: Radius.circular(40)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  selectedItemColor: Colors.teal,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  onTap: (index){
                    cubit.onTapItem(index);
                  },

                  // color: Colors.white,
                  // buttonBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  // animationCurve: Curves.easeInCubic,
                  // animationDuration: Duration(milliseconds: 600),

                  items: [
                    BottomNavigationBarItem(icon: Image.asset('assets/home.png' , scale: 20,),
                    label: 'Home',
                    ),


                    BottomNavigationBarItem(icon: Image.asset('assets/categories.png' , scale: 20,),
                      label: 'Category',
                    ),



                    BottomNavigationBarItem(icon: Image.asset('assets/heart.png' , scale: 20,),
                      label: 'Favorite',
                    ),



                    BottomNavigationBarItem(icon: Image.asset('assets/user.png' , scale: 20,),
                      label: 'Profile',
                    ),


                ]

                ),
              ),
            ),

          );
          },
      ),
    );
  }
}
