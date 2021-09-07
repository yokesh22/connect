import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo{

 Future getUser(username) async {
    List items=[];
    await FirebaseFirestore.instance.collection("users").where('name',isEqualTo: username).
    get().then((querysnapshots){
      querysnapshots.docs.forEach((element) {
        items.add(element.data());
      });
    });
    return items;
  }

  uploadUser(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap()).catchError(
        (e){
          print(e.toString());
        }
    );
  }
  
  createChatRoom(String chatRoomId,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").
    doc(chatRoomId).set(chatRoomMap).
    catchError((e){
      print(e.toString());
    });
  }



 uploadMessages(chatRoomId,chatRoomMap){
   FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).
   collection("chats").add(chatRoomMap).catchError((e){
     print(e.toString());
   });
  }
 Future getMessages(chatRoomId)async{
   return FirebaseFirestore.instance.collection("ChatRoom").
   doc(chatRoomId).collection("chats").
   orderBy('time',descending: false).
   snapshots();
 }
  
Future usersInChatMenu(userName)async{
  return  FirebaseFirestore.instance.collection("ChatRoom").
  where("users",arrayContains:userName ).snapshots();

}

}

class AuthMethodsS{
  Future getUserEmail(userEmail) async {
    List items=[];
    await FirebaseFirestore.instance.collection("users").where('email',isEqualTo: userEmail).
    get().then((querysnapshots){
      querysnapshots.docs.forEach((element) {
        items.add(element.data());
      });
    });
    return items;
  }

}