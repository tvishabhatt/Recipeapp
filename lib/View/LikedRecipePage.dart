import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/Controller/FirebaseHelper.dart';

class LikedRecipePage extends StatefulWidget {
  const LikedRecipePage({Key? key}) : super(key: key);

  @override
  State<LikedRecipePage> createState() => _LikedRecipePageState();
}

class _LikedRecipePageState extends State<LikedRecipePage> {
  FirebaseHepler firebaseHepler=FirebaseHepler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Recipes"),
        automaticallyImplyLeading: true,

      ),
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: firebaseHepler.getfavourite(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child:
              Text("There is error in loding data "),);

          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot<Map<String,dynamic>>> allrecipes = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (context, i) {
            return allrecipes.isNotEmpty?Text("Do Liked recipe yet"):ListTile(
              title: Text("Name : ${allrecipes[i]['name']}"),
              subtitle: Text("Descirpation : ${allrecipes[i]['descirpation']}"),
              trailing: IconButton(onPressed: () {
                firebaseHepler.deleterecipe(docId:allrecipes[i].id );
              }, icon: Icon(Icons.delete),),
            );
          },);
        },
      ),
    );
  }
}
