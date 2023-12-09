
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/category_datails.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/home_layout.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/state.dart';

class favorite_screen extends StatefulWidget {

  @override
  State<favorite_screen> createState() => _favorite_screenState();
}

class _favorite_screenState extends State<favorite_screen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getFav(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
        builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
                condition: state is AppGetCategoryProductsSuccessState || state is AppGetFavoritesSuccessState || state is AppGetCartSuccessState,
                builder: (context)=>ConditionalBuilder(
                    condition: cubit.favorites.isNotEmpty,
                    builder: (context)=>Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemBuilder: (context , index)=>buildFavorite(cubit.favorites[index] , index),
                        separatorBuilder: (context , index)=>myDivider(),
                        itemCount: cubit.favorites.length,
                      ),
                    ),
                  fallback: (context)=>Center(child: Text('No Favorites Yet!' , style: TextStyle(fontSize: 20),)),
                ),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),
            ),
          );
        },
      ),
    );
  }

  Widget buildFavorite(list , index) => Column(
    children: [
      Row(
        children: [
          Container(width: 100, child: Image(image: NetworkImage(list['product']['image']),)),
          SizedBox(
            width: 10,
          ),
          Expanded(child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(list['product']['name']),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(list['product']['price'].toString()),
                SizedBox(
                  width: 20,
                ),
                Text(list['product']['old_price'].toString() , style: TextStyle(decoration: TextDecoration.lineThrough , color: Colors.red)),
              ],
            ),
            ],
           ),
          ),

          IconButton(onPressed: (){
            setState((){
              AppCubit().deleteFav(list['product']['id']);
            });

          },
              icon:Icon(Icons.delete , color: Colors.red,)
          ),
        ],
      ),
    ],
  );
}
