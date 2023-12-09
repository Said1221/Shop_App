

import 'package:flutter/material.dart';
import 'package:shop_app/cubit.dart';

BuildContext context;

Widget buildDetails(list) =>Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    title: Text(list['name'] , style: TextStyle(color: Colors.black),),
  ),
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: NetworkImage(list['image'])),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list['price'].toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 15),),
                list['old_price'] != null ? Text(list['old_price'].toString() , style: TextStyle(color: Colors.red ,fontWeight: FontWeight.bold , fontSize: 15 , decoration: TextDecoration.lineThrough),)
                    : Text(''),

              ],
            ),
          ),

          Row(
            children: [
              Expanded(child: Text(list['name'] , style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          Text(list['description']),

          SizedBox(
            height: 15,
          ),

          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.orange[300],
                  Colors.deepOrange,
                  Colors.orange[300]
                ]
              )
            ),
            width: double.infinity,
            child: MaterialButton(onPressed: (){
              AppCubit().postCart(list['id']);
            },
              child: Text('Add to Cart'),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [
                      Colors.redAccent[100],
                      Colors.redAccent[400],
                      Colors.redAccent[100],
                    ]
                )
            ),

            width: double.infinity,
            child: MaterialButton(onPressed: (){
              AppCubit().postFav(list['id']);
            },
              child: Text('Add to Favorite'),
            ),
          )
        ],
      ),
    ),
  ),
);