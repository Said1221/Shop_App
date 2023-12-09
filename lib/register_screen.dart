
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/my_clipper.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/register/cubit.dart';
import 'package:shop_app/register/state.dart';

class register_screen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppRegCubit(),
      child: BlocConsumer<AppRegCubit , AppRegState>(
        listener: (BuildContext context , AppRegState state){
          if(state is AppRegSuccessState){
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );
            navigateTo(context, loginScreen());
          }

          if(state is AppRegErrorState){
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.red,
            );
          }
        },

          builder: (BuildContext context , AppRegState state){
          AppRegCubit cubit = AppRegCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      ClipPath(
                        clipper: MyClipper(),
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


                      Text(
                        'Create an account',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter your name';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Name'),
                            prefixIcon:Icon(
                              Icons.person,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value)=>
                          value.isNotEmpty ? 'error' : null,

                        decoration: InputDecoration(
                            label: Text('Email Address'),
                            prefixIcon: Icon(
                              Icons.email,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter your phone number';
                          }
                        },
                        decoration: InputDecoration(
                            label: Text('Phone Number'),
                            prefixIcon:Icon(
                              Icons.phone,
                            )
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter your password';
                          }
                        },
                        decoration: InputDecoration(
                          label: Text('Password'),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ConditionalBuilder(
                          condition: state is! AppRegLoadingState,
                          builder: (BuildContext)=>Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.blue[100],
                                        Colors.blue,
                                        Colors.blue[100],
                                      ]
                                  )
                              ),
                              width: double.infinity,
                              child: MaterialButton(onPressed: (){
                                cubit.regUser(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              },

                                child: Text('Register',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        fallback: (BuildContext)=>Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          },
      ),
    );
  }
}
