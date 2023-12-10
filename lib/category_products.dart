
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/state.dart';

class category_products_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getCategoryProducts(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
        builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black
              ),
              backgroundColor: Colors.white,
              title: Text(title , style: TextStyle(color: Colors.black),),
            ),
            body: ConditionalBuilder(
                condition: state is AppGetCategoryProductsSuccessState || state is AppGetFavoritesSuccessState || state is AppGetCartSuccessState,
                builder: (BuildContext)=>Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        childAspectRatio: 1/2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        children: List.generate(cubit.categoryProducts.length, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Image(image: NetworkImage(cubit.categoryProducts[index]['image']),)),
                                  Text(cubit.categoryProducts[index]['name']),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cubit.categoryProducts[index]['price'].toString()),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(cubit.categoryProducts[index]['old_price'].toString() , style: TextStyle(decoration: TextDecoration.lineThrough , color: Colors.red),),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      IconButton(onPressed: (){
                                        cubit.postCart(cubit.categoryProducts[index]['id']);
                                      },
                                        icon: cart[AppCubit.get(context).categoryProducts[index]['id']] == true ? Icon(Icons.shopping_cart_rounded , size: 17, color: Colors.orange,) : Icon(Icons.shopping_cart_outlined , size: 17,),
                                      ),


                                      IconButton(onPressed: (){
                                        cubit.postFav(cubit.categoryProducts[index]['id']);
                                      },
                                        icon: favorite[AppCubit.get(context).categoryProducts[index]['id']] == true ? Icon(Icons.favorite , size: 17, color: Colors.red,) : Icon(Icons.favorite_border , size: 17,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              fallback: (BuildContext)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),
            ),
          );
        },
      ),
    );
  }
}
