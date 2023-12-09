
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/category_products.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/cubit.dart';
import 'package:shop_app/state.dart';


class category_screen extends StatefulWidget {

  @override
  State<category_screen> createState() => _category_screenState();
}

class _category_screenState extends State<category_screen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit()..getCategory(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                          condition: state is AppGetCategorySuccessState,
                          builder: (BuildContext)=>ListView.separated(
                            itemBuilder: (context , index)=>buildCategory(cubit.category[index] , context),
                            separatorBuilder: (context , index)=>myDivider(),
                            itemCount: cubit.category.length,
                          ),
                        fallback: (BuildContext)=>Center(child: CircularProgressIndicator(color: Colors.teal,)),
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

  Widget buildCategory(list , context) => InkWell(
    onTap: () async{
      setState((){
        title = list['name'];
        detId = list['id'];
      });
      await AppCubit().getCategoryProducts();
      navigateTo(context, category_products_screen());
    },
    child: Row(
      children: [
        Container(width: 100, child: Image(image: NetworkImage(list['image']),)),
        SizedBox(
          width: 10,
        ),
        Expanded(child: Text(list['name'])),
      ],
    ),
  );
}
