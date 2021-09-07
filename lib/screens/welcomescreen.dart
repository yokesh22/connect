import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projects/screens/signin.dart';
import 'package:flutter_projects/screens/signup.dart';
class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height*0.12,
                padding: EdgeInsets.only(top: 30.0),
                alignment: Alignment.center,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello there , here is a friendly platform to connect with people",
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    SizedBox(height: 25.0,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: size.width,
                      height: size.height*0.4-10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/welcome.png"),
                            fit: BoxFit.fitHeight
                        ),
                      ),
                    ),
                    SizedBox(height: 18.0,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
                            },
                            child: Container(
                              width: double.infinity,
                              height: size.height*0.075,
                              decoration: BoxDecoration(
                                  boxShadow:  [
                                    BoxShadow(
                                      color: Colors.white24,
                                      offset: const Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 3.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(30.0)
                              ),
                              child: Center(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.0,),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));

                            },
                            child: Container(
                              width: double.infinity,
                              height: size.width*0.15,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff9AECDB),
                                        Colors.lightBlue,
                                        //Colors.indigoAccent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
