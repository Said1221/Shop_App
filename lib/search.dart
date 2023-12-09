
import 'dart:ffi';


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category_datails.dart';
import 'package:shop_app/category_products.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/state.dart';

class search_screen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            icon: Icon(Icons.keyboard_backspace)
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: searchController,
                                keyboardType: TextInputType.text,
                                onChanged: (value){
                                  cubit.postSearch(searchController.text);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                  label: Text('search'),
                                ),
                              ),
                              ConditionalBuilder(
                                  condition: state is AppPostSearchSuccessState,
                                  builder: (BuildContext)=>LinearProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index)=>build_search(context , cubit.search[index]),
                        separatorBuilder: (context , index)=>myDivider(),
                        itemCount: cubit.search.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          },
      ),
    );
  }
  
  
  Widget build_search(context , list)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: ()=> navigateTo(context, buildDetails(list)),
      child: Row(
        children: [
          Image(image: NetworkImage(list['image']) , width: 100, height: 100,),
          SizedBox(
            width: 10,
          ),
          Expanded(child: Text(list['name'])),
        ],
      ),
    ),
  );
  
}
