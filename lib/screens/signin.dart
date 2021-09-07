import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_projects/screens/signup.dart';
import 'package:flutter_projects/services/database.dart';
import 'package:flutter_projects/services/sharedPreference.dart';

import 'chatmenuscreen.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool isloading = false;
  AuthMethodsS authMethodsS = new AuthMethodsS();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  List userNames =[];

  fetcher()async{
    dynamic result = await authMethodsS.getUserEmail(_email.text);
    if(result == null){
      print("error..");

    }else{
      setState(() {
        userNames = result;
        print(userNames);
      });
    }
  }
  void login()async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await fetcher();
      setState(() {
        isloading = true;
      });
      await auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text).then((value) {
        SharedPreferenceFunctions.saveUserName(userNames[0]["name"]);
        print("${userNames[0]["name"]}");
        SharedPreferenceFunctions.saveUserEmail(_email.text);
        SharedPreferenceFunctions.userLoggedIn(true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChatMenu()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      body:isloading?
      Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ):
      SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50.0,left: 20.0,right: 20.0),
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                child: Text(
                  "Login to your account",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!) ? null : "Enter a valid email";
                        },
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          labelText: "Enter Email",
                          labelStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white54
                          ),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        controller: _password,
                        validator: (val){
                          return val!.length<7 && val.length<10 && val.isEmpty?"enter a valid password":null;
                        },
                        style: TextStyle(
                            color: Colors.white
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          labelStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white54
                          ),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                    login();
                  },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                  child: Container(
                    child: Center(
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18.0,

                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));

                    },
                    child: Text(
                      "Signup.",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: size.height/2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.png")
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
