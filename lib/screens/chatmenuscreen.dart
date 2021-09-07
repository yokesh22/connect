import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_projects/screens/chatroom.dart';
import 'package:flutter_projects/screens/searchscreen.dart';
import 'package:flutter_projects/screens/signup.dart';
import 'package:flutter_projects/services/auth.dart';
import 'package:flutter_projects/services/database.dart';
import 'package:flutter_projects/services/sharedPreference.dart';

import 'drawer.dart';
class ChatMenu extends StatefulWidget {

  @override
  _ChatMenuState createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  String presentUser="";
    UserInfo userInfoDb = new UserInfo();
       late final Stream<QuerySnapshot> getUsersStream;

  Widget chats(){
    return StreamBuilder<QuerySnapshot>(
      stream: getUsersStream,
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
        return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ChatMenuUserTile(
                  snapshot.data!.docs[index]["chatroomId"].
                toString().replaceAll("_", "").replaceAll(presentUser,""),
                snapshot.data!.docs[index]["chatroomId"],

              );
            }
        ):Container();
      },
    );
  }

   userInfo() async{
      presentUser = await SharedPreferenceFunctions.getUserName();
      await userInfoDb.usersInChatMenu(presentUser).then((value){
        print(value);
       setState(() {
         getUsersStream = value;
       });
     });
     print(presentUser);
   }

   @override
   void initState() {
     super.initState();
     userInfo();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: CustomDrawer(presentUser),
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchUser(presentUser)));
        },
        backgroundColor:  Color(0xff082144),
        child: Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
      ),
      body: chats()
    );
  }
}
class ChatMenuUserTile extends StatelessWidget {
final String username;
final String chatRoomId;
ChatMenuUserTile(this.username,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(chatRoomId)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.black12
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blueGrey
              ),
              child: Text(
                "${username.substring(0,1).toUpperCase()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(width: 20.0,),
            Container(
              child: Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
