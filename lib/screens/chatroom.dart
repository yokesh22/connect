import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_projects/screens/chatmenuscreen.dart';
import 'package:flutter_projects/services/database.dart';
import 'package:flutter_projects/services/sharedPreference.dart';

class ChatRoom extends StatefulWidget {
final String chatRoomId;
ChatRoom(this.chatRoomId);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = new TextEditingController();
  UserInfo userInfo = new UserInfo();
  late final String presentUser ;
  late final Stream<QuerySnapshot> getMessagesStream;
  //function to get current user for SendBy

  //Function to upload users chat to collections
  createConversation(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> chatRoomMap = {
        "message" : messageController.text,
        "sendBy" : presentUser,
        "time" : DateTime.now().microsecondsSinceEpoch
      };
      userInfo.uploadMessages(widget.chatRoomId, chatRoomMap);
      messageController.clear();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Type message"),
        )
      );
    }


  }
  Widget messageList(){
    return StreamBuilder<QuerySnapshot>(
      stream: getMessagesStream,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
        return snapshot.hasData? ListView.builder(
          shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return MessageTile(
                  snapshot.data!.docs[index]['message'],
                  snapshot.data!.docs[index]['sendBy'] == presentUser,
              );

        }
        ) : Container();
        }
    );
  }

  currentUser()async{
    presentUser = await SharedPreferenceFunctions.getUserName();
    await userInfo.getMessages(widget.chatRoomId).then((value){
      print(value);
      setState(() {
        getMessagesStream=value;
      });
    });
    setState(() {
    });

  }

  @override
  void initState() {
    super.initState();
    currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:  Color(0xff111113),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMenu()));
            },
            child: Icon(
              Icons.arrow_back_ios
            ),
          ),
          title: Text(
            "${widget.chatRoomId.toString().replaceAll("_", "").replaceAll(presentUser, "")}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 23.0
            ),
          ),
          backgroundColor: Color(0xff082144),
        ),
        body:
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.78,
                    child: messageList(),

                  ),
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      width: double.infinity,
                      child:  Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              autofocus: false,
                              decoration: InputDecoration(
                                labelText:"Type message...",
                                labelStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white54,
                                ),
                                fillColor: Colors.blueGrey,
                                filled: false,
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
                                createConversation();
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // searchList(),
                        ],
                      ),
                    ),
                )

              ],
            ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
final String message;
final bool isSendByMe;
MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: isSendByMe? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 13.0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isSendByMe? Colors.indigo :Colors.grey,
          borderRadius: isSendByMe? BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
          ):BorderRadius.only(
            topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              bottomRight:  Radius.circular(10.0)
          ),
        ),
        child: Text(
            message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0
          ),
        ),
      ),
    );
  }
}

