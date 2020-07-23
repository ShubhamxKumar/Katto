import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var userInfo = {
  'userName': '',
  'userEmail': '',
  'profilePic': null,
  'userId': '',
  'fullname': '',
  'liked': 0,
  'followers': 0,
  'following': 0,
  'videos': [],
  'numberofvideos': 0,
};

Future<bool> getUserInfo() {
  if (FirebaseAuth.instance.currentUser != null) {
    FirebaseAuth.instance.currentUser().then((user) async {
      try {
        await Firestore.instance
            .collection('Users')
            .document(user.uid)
            .get()
            .then((doc) {
          if (doc.exists) {
            userInfo['fullname'] = doc.data['fullname'];
            userInfo['username'] = doc.data['username'];
            userInfo['useremail'] = doc.data['useremail'];
            userInfo['userId'] = doc.data['userId'];
            userInfo['profilePic'] = doc.data['profilePic'];
            userInfo['liked'] = doc.data['liked'];
            userInfo['following'] = doc.data['following'];
            userInfo['followers'] = doc.data['followers'];
            userInfo['videos'] = doc.data['videos'];
            userInfo['numberofvideos'] = doc.data['videos'].length;
          }
        });
      } catch (err) {
        print(err.message);
        return false;
      }
    }).then((user) {
      print(userInfo);
      return true;
    });
  }
}

clearUserInfo() {
  userInfo = {
    'userName': '',
    'userEmail': '',
    'profilePic': null,
    'userId': '',
    'fullname': '',
    'liked': 0,
    'followers': 0,
    'following': 0,
    'videos': [],
    'numberofvideos': 0,
  };
}
