import 'package:flutter/material.dart';
import 'package:recipeapp/Controller/DBHelper.dart';
import 'package:recipeapp/Controller/FirebaseHelper.dart';
import 'package:recipeapp/Model/RecipesModal.dart';
import 'package:recipeapp/View/LikedRecipePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  DBHelper dbHelper=DBHelper();
  FirebaseHepler firebaseHepler=FirebaseHepler();
  List<RecipesModal> _recipes= [];
  @override
  void initState() {

    super.initState();
  }

  Future<void> getrecipes()async{
    final recipes = dbHelper.getrecipes();
    setState(() {
      _recipes=recipes as List<RecipesModal>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black12,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LikedRecipePage(),));
          }, icon:Icon( Icons.favorite),color: Colors.red,)
        ],
      ),
      body:FutureBuilder(
          future: dbHelper.getrecipes(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(child: Text("There is error in loding data"));

            }
            else if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            return _recipes.isEmpty?
            Center(child: Text("No Recipes there")):
              ListView.builder(
              itemCount: _recipes.length,
                itemBuilder: (context, i) {
                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile (
                      title: Text("${_recipes[i].name}"),
                      subtitle: Text("${_recipes[i].descipation}"),
                      trailing: Row(
                        children: [
                          IconButton(onPressed: () {
                            ShowUpdaterecipesDialog(_recipes[i].name,_recipes[i].descipation);
                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: () {

                            firebaseHepler.createcoolection(name: _recipes[i].name, descirpation: _recipes[i].descipation);
                            setState(() {
                            });
                          }, icon: Icon(Icons.favorite)),

                          IconButton(onPressed: () {
                            RecipesModal modal=RecipesModal(name: _recipes[i].name, descipation: _recipes[i].descipation);
                            dbHelper.deleterecipes(modal);
                            setState(() {

                            });
                          }, icon: Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  ),
                );
                },

            );
          },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowAddrecipesDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future ShowAddrecipesDialog(){
    TextEditingController name=TextEditingController();
    TextEditingController descirpation =TextEditingController();

    
      return showDialog(context: context,
          builder: (context) {
            return Scaffold(
              body: Column(
                children: [
                  Text("Add recipes"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Name Of Recipe",
                        border: OutlineInputBorder(),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descirpation,
                      decoration: InputDecoration(
                        hintText: "Ingirdents Of Recipe",
                        border: OutlineInputBorder(),

                      ),),
                  ),
                  ElevatedButton(onPressed: () {
                    String recipename = name.text;
                    String reciped = descirpation.text;
                    RecipesModal modal = RecipesModal(
                        name: recipename, descipation: reciped);
                    dbHelper.addrecipes(modal);
                    setState(() {

                    });
                    Navigator.pop(context);
                  }, child: Text("FAB")),

                ],
              ),
            );
          }    
    );
    


  }


  Future ShowUpdaterecipesDialog(String oldname,String des){
    TextEditingController name=TextEditingController(text: oldname);
    TextEditingController descirpation =TextEditingController(text: des);
    return showDialog(context: context,
        builder: (context)
        {
          return Scaffold(
            body: Column(
              children: [
                Text("Add recipes"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Name Of Recipe",
                      border: OutlineInputBorder(),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: descirpation,
                    decoration: InputDecoration(
                      hintText: "Ingirdents Of Recipe",
                      border: OutlineInputBorder(),

                    ),),
                ),
                ElevatedButton(onPressed: () {
                  String recipename=name.text;
                  String reciped=descirpation.text;
                  RecipesModal modal=RecipesModal(name: recipename, descipation: reciped);
                  dbHelper.Updaterecipes(modal);
                  setState(() {
            
                  });
                }, child: Text("Add")),
            
              ],
            ),
          );
        });


  }
}
