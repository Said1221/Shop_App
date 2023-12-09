
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/state.dart';

class cart_screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getCart(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context, AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text('Cart' , style: TextStyle(color: Colors.black)),
            ),
            body: ConditionalBuilder(
                condition: state is AppGetCartSuccessState,
                builder: (context)=>ConditionalBuilder(
                  condition: cubit.carts.isNotEmpty,
                  builder: (context)=>ListView.separated(
                    itemBuilder: (context , index)=>buildCart(cubit.carts[index]),
                    separatorBuilder: (context , index)=>myDivider(),
                    itemCount: cubit.carts.length,
                  ),
                  fallback: (context)=>Center(child: Text('Your Cart is Empty!' , style: TextStyle(fontSize: 20),)),
                ),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),

            ),
          );
          },
      ),
    );
  }

  Widget buildCart(list)=>InkWell(
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                  AppCubit().postCart(list['product']['id']);
                },
                    icon:Icon(Icons.delete , color: Colors.red,)
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

}
