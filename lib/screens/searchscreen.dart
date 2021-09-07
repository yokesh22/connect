import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projects/screens/chatmenuscreen.dart';
import 'package:flutter_projects/screens/chatroom.dart';
import 'package:flutter_projects/screens/signup.dart';
import 'package:flutter_projects/services/auth.dart';
import 'package:flutter_projects/services/database.dart';
import 'package:flutter_projects/services/sharedPreference.dart';

import 'drawer.dart';
class SearchUser extends StatefulWidget {
  String presentUser;
  SearchUser(this.presentUser);
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  UserInfo userInfo =new UserInfo();
  TextEditingController searchController=new TextEditingController();
  ChatMenu chatMenu = new ChatMenu();
  List usersName = [];
  // late final String presentUser ;
  // initiatesearchUser()async{
  //   await _userInfo.getUser(searchController.text);
  // }
  // Widget searchList(){
  //   return ListView.builder(
  //     shrinkWrap: true,
  //       itemCount: querySnapshot!.docs.length,
  //       itemBuilder: (context,index){
  //         return ListView(
  //           children:[
  //             UserTile(
  //               email: querySnapshot!.docs[index]['email'],
  //               username: querySnapshot!.docs[index]['name']
  //           ),
  //         ],
  //         );
  //       }
  //   );
  // }
  // currentUser()async{
  //   presentUser = await SharedPreferenceFunctions.getUserName();
  // }
  fetchUser() async{
    dynamic result = await userInfo.getUser(searchController.text);

    if(result == null){
      print("error..");

    }else{
      setState(() {
        usersName = result;
      });
    }
  }

  getChatRoomId(String a,String b){
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }
//here toUsername = username
  sendingUsersToChatScreen(String toUserName)async{
    //print(toUserName);
    // print(SharedPreferenceFunctions.getUserName());
   if(toUserName !=widget.presentUser){
     String processedChatRoomId = getChatRoomId(toUserName,widget.presentUser);
     List users = [toUserName,widget.presentUser];
     Map<String,dynamic> chatRoomMap ={
       "users" : users,
       "chatroomId" : processedChatRoomId
     };
     userInfo.createChatRoom(processedChatRoomId, chatRoomMap);
     Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(processedChatRoomId)));

   }else{
     print("Username error.........");
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
           content: Text("You can't message to yourself!")
       )
     );
   }
  }


  Widget userTile({username,email}){
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white30,
                Colors.grey
              ]
          ),
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              print(username);
              print(widget.presentUser);
              sendingUsersToChatScreen(username);
            },
            child: Container(
              width: 120.0,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Color(0xff082144)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  "Message",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    fetchUser();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: CustomDrawer(widget.presentUser),
        ),
        backgroundColor:  Color(0xff111113),
        appBar: AppBar(
          title: Text(
            "Connect",
            style: TextStyle(
                color: Colors.white,
                fontSize: 23.0
            ),
          ),
          backgroundColor: Color(0xff082144),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              child: GestureDetector(
                onTap: (){
                  AuthMethods().signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                },
                child: Icon(
                  Icons.vpn_key_sharp,
                  size: 25.0,
                  color: Colors.white54,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                          color: Colors.white
                      ),
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText:"Search user",
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white54
                        ),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.white54,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13.0,),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                    child:  GestureDetector(
                      onTap: (){
                        fetchUser();
                      },
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // searchList(),
                ],
              )

              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                itemCount: usersName.length,
                  itemBuilder: (context,index){
                    // return ListTile(
                    //   title: Text(
                    //     usersName[index]['name']
                    //   ),
                    //   subtitle: Text(
                    //     usersName[index]['email']
                    //   ),
                    // );
                    return userTile(
                        email: usersName[index]['email'],
                        username: usersName[index]['name']
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
