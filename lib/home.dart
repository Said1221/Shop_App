

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category_datails.dart';
import 'package:shop_app/category_products.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/shared_pref.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/home_layout.dart';
import 'package:shop_app/state.dart';

class home_screen extends StatefulWidget {



  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..homeBanner()..getProducts()..getCategory(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.products.isNotEmpty,
            builder: (BuildContext)=>Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider.builder(
                        itemCount: cubit.data.length,
                        itemBuilder: (BuildContext, int index , int realIndex){
                          return Image(
                              image: NetworkImage(cubit.data[index]['image']),
                              width: double.infinity,
                              fit: BoxFit.cover
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          reverse: false,
                          autoPlay: true,
                        )
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Categories' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index)=> Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                InkWell(
                                  onTap:()async{
                                    setState((){
                                      title = cubit.category[index]['name'];
                                      detId = cubit.category[index]['id'];
                                    });
                                    await AppCubit().getCategoryProducts();
                                    navigateTo(context , category_products_screen());
                                  },
                                    child: Container(height: 100 , width: 100, child: Image(image: NetworkImage(cubit.category[index]['image']),))),
                                Container(width: 100, color: Colors.black.withOpacity(0.8) ,child: Text(cubit.category[index]['name'], textAlign: TextAlign.center, style: TextStyle(color: Colors.white , overflow: TextOverflow.ellipsis),)),
                              ],
                            ),
                          ],
                        ),
                        separatorBuilder: (context , index)=>SizedBox(width: 10,),
                        itemCount: cubit.category.length,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('New Products' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                  ),




                  Expanded(
                    child: GridView.count(
                      childAspectRatio: 1/2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(cubit.products.length, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: InkWell(
                          onTap: ()=>navigateTo(context , buildDetails(cubit.products[index])),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Image(image: NetworkImage(cubit.products[index]['image']))),
                                  Text(cubit.products[index]['name']),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cubit.products[index]['price'].toString()),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(cubit.products[index]['old_price'].toString() , style: TextStyle(decoration: TextDecoration.lineThrough , color: Colors.red),),
                                        ],
                                      ),
                                      SizedBox(
                                        width:14,
                                      ),

                                      IconButton(onPressed: (){
                                          cubit.postCart(cubit.products[index]['id']);
                                      },

                                        icon: cart[AppCubit.get(context).products[index]['id']] == true ? Icon(Icons.shopping_cart_rounded , size: 17, color: Colors.orange,) : Icon(Icons.shopping_cart_outlined , size: 17,),


                                      ),

                                      IconButton(onPressed: (){
                                        cubit.postFav(cubit.products[index]['id']);
                                        },
                                          icon: favorite[AppCubit.get(context).products[index]['id']] == true ? Icon(Icons.favorite , size: 17, color: Colors.red,) : Icon(Icons.favorite_border , size: 17,),
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
                  ),

                ],
              ),
            ),
            fallback: (BuildContext)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),
          );




          }
      ),
    );

    

  }




}
