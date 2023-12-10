
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/state.dart';

class cart_screen extends StatefulWidget {


  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
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
                condition: state is! AppLoadingCartSuccessState && state is AppGetCartSuccessState,
                builder: (context)=>ConditionalBuilder(
                  condition: cubit.carts.isNotEmpty,
                  builder: (context)=>ListView.separated(
                    itemBuilder: (context , index){
                      return Dismissible(
                          key: GlobalKey<FormState>(),
                          child: buildCart(cubit.carts[index]),
                        onDismissed: (direction){
                          [cubit.carts[index]].removeAt(index);
                          setState((){
                            cubit.postCart(cubit.carts[index]['product']['id']);
                          });
                        },
                          background: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.red[400],
                                      Colors.red[200],
                                    ]
                                )
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Delete' , style: TextStyle(fontSize: 30 , color: Colors.white , fontStyle: FontStyle.italic),),
                                  Icon(Icons.delete , color: Colors.white,),
                                ],
                              ),
                            ),
                          )

                      );
                    },
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
                },
                    icon:Icon(Icons.swap_horiz , color: Colors.red,)
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
