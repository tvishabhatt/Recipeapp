class RecipesModal{
  int?id ;
   String name;
   String descipation;
  
  RecipesModal({this.id,required this.name,required this.descipation});
  
  Map<String,dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'descipation': descipation,
    };
  }
    factory RecipesModal.fromMap(Map<String,dynamic> data){
      return RecipesModal(
        id: data['id'],
          name: data['name'],
          descipation: data['descipation']);
    }
  
}