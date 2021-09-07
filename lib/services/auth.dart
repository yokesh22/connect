import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp(String email,String password) async{
    try{
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user!.uid;
    }catch(e){
      print(e.toString());
    }
  }
// Future signIn(String email,String password) async{
//   try{
//       final result =
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return result.user!.uid;
//   }on FirebaseAuthException catch(e){
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }
// }


  Future resetPass(String email) async{
    try{
      return _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
  Future signOut()async{
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }


}