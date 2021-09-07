import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_projects/screens/signin.dart';
import 'package:flutter_projects/services/auth.dart';
import 'package:flutter_projects/services/database.dart';
import 'package:flutter_projects/services/sharedPreference.dart';
import 'chatmenuscreen.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  AuthMethods _authMethods = new AuthMethods();
  UserInfo userInfo = new UserInfo();
  bool isLoading=false;
  final formKey=GlobalKey<FormState>();

 signUp(){
      if (formKey.currentState!.validate()) {
        Map<String, String> userMap() {
          return {
            'name': _username.text,
            'email': _email.text,
          };
        }
        SharedPreferenceFunctions.saveUserName(_username.text);
        SharedPreferenceFunctions.saveUserEmail(_email.text);
        setState(() {
          isLoading = true;
        });
        _authMethods.signUp(_email.text, _password.text).then(
                (value) {
              //print('${value.uid}');
              userInfo.uploadUser(userMap);
              SharedPreferenceFunctions.userLoggedIn(true);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatMenu()));
            }
        );
      }
    }


  @override

  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                alignment: Alignment.center,
                child: Text(
                  "Create your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _username,
                        validator: (val){
                          return val!.isEmpty || val.length<=4?"Username should has 4 character":null;
                        },
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          labelText: "Enter Username",
                          labelStyle: TextStyle(
                              fontSize: 16.0,
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
                        controller: _email,
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)?
                          null:"enter a valid Email";
                        },
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          labelText: "Enter email",
                          labelStyle: TextStyle(
                              fontSize: 16.0,
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
                          labelText: "Enter password",
                          labelStyle: TextStyle(
                              fontSize: 16.0,
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

                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: (){
                  signUp();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.0),
                  width: double.infinity,
                  height: size.width*0.15,
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
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21.0
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: (){

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/googlelogo.png"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(width: 10.0,),

                      Container(

                        child: Text(
                          "Sign up with Google",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have a account? ",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18.0
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));

                    },
                    child: Text(
                      "Signin.",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
