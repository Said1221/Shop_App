
import 'package:flutter/material.dart';
import 'package:shop_app/constant/component.dart';
import 'package:shop_app/constant/my_clipper.dart';
import 'package:shop_app/login_screen.dart';
import 'package:shop_app/onBoarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingModel{
String image;
String title;
String info;
String body;

onBoardingModel({
  this.image,
  this.title,
  this.info,
  this.body,
});
}

class onBoarding extends StatefulWidget {

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  
  var borderController = PageController();
  var last;

  List<onBoardingModel>boarding = [

    onBoardingModel(
      image : 'assets/board.jpg',
      title: 'Welcome',
      info: 'This app displays products that you may want to purchase',
    ),

    onBoardingModel(
      image : 'assets/1.jpg',
      title: 'SignIn',
      info: 'The application to be able to shop',
    ),

    onBoardingModel(
      image : 'assets/2.jpg',
      title: 'Skip',
      info: 'To be able to SignIn or SignUp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                          onPageChanged: (int index){
                          if(index == boarding.length-1){

                              setState((){
                                last = 'last';
                              });

                           }
                          else{
                            setState((){
                              last = '';
                            });
                          }
                          },
                          controller: borderController,
                          itemBuilder: (context , index)=> buildOnBoarding(boarding[index]),
                        itemCount: boarding.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 30 , right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: SmoothPageIndicator(
                                controller: borderController,
                                count: boarding.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: Colors.blue,
                                dotColor: Colors.blue,
                                dotHeight: 10,
                                expansionFactor: 4,
                                dotWidth: 10,
                                spacing: 5,
                              ),
                            ),
                          ),
                          FloatingActionButton(onPressed: (){
                            borderController.nextPage(
                                duration: Duration(
                                  microseconds: 750,
                                ),
                                curve: Curves.bounceInOut
                            );
                            if(last == 'last'){
                              navigateTo(context, loginScreen());
                            }
                          },
                            backgroundColor: Colors.blue,
                          child: last == 'last' ? Icon(Icons.login) : Icon(Icons.navigate_next),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(onBoardingModel model)=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 30 , left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.blue),),
            SizedBox(
              height: 5,
            ),
            Text(model.info , style: TextStyle(fontSize: 15 , color: Colors.grey),),
          ],
        ),
      ),
    ],
  );
}
