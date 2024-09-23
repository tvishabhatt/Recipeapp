import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseHepler{
  final  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  
  Future createcoolection({required String name,required String descirpation})async{


    await firebaseFirestore.collection('favourite').add({
      'name':name,
      'descirpation':descirpation,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getfavourite(){
    Stream<QuerySnapshot<Map<String, dynamic>>> allrecipes = firebaseFirestore.collection('favourite').snapshots();
    return allrecipes;
  }

  Future<void> deleterecipe({required String docId})async{


    await firebaseFirestore.collection('favourite').doc(docId).delete();
  }


  
}