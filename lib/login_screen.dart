
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/my_clipper.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/home_layout.dart';
import 'package:shop_app/login/cubit.dart';
import 'package:shop_app/login/state.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/register_screen.dart';

class loginScreen extends StatelessWidget {

  loginModel model;

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (BuildContext context)=>AppLoginCubit(),
          child: BlocConsumer<AppLoginCubit , AppLoginState>(
            listener: (BuildContext context , AppLoginState state){
              if (state is AppLoginSuccessState){
                Fluttertoast.showToast(
                  msg: message,
                  timeInSecForIosWeb: 3,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 16,
                  backgroundColor: Colors.green,
                );
                navigateTo(context, home_layout());
              }

              if(state is AppLoginErrorState){
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
              builder: (BuildContext context , AppLoginState state){
              AppLoginCubit cubit = AppLoginCubit.get(context);
              return SafeArea(
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

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



                        Container(
                          child: Text(
                            'Login Screen',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: EmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Email Address'),
                              prefixIcon:Icon(
                                Icons.email,
                              )
                          ),
                        ),
                        TextFormField(
                          controller: PasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(
                                Icons.lock,
                              )
                          ),
                        ),

                      SizedBox(
                        height: 10,
                      ),

                      ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (BuildContext)=> Container(
                    width: double.infinity,
                    child: Padding(
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
                        child: MaterialButton(onPressed: (){
                          cubit.loginUser(
                            EmailController.text,
                            PasswordController.text,
                          );
                        },
                          child: Text('Login',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                        fallback: (BuildContext)=>Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ),

                        Center(
                          child: TextButton(onPressed: (){
                            navigateTo(context , register_screen());
                          },
                            child: Text('Create an account ?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
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
}
