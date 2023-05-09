class ChangeFavoritesModel
{
  bool? status;
  FavoritesDataModel? data;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json)
  {
    status =json['status'];
    data =FavoritesDataModel.fromJson(json['data']);
  }
}
class FavoritesDataModel
{
  int? current_page;
  List<DataModel> data=[];

  FavoritesDataModel.fromJson(Map<String,dynamic> json)
  {
    current_page=json['current_page'];
    json['data'].forEach((element)
    {
      data.add(DataModel.fromJson(element));
    });
    // data =json['data'];
  }
}
class DataModel
{
  // int? id;
  // String name='';
  String message='';

  DataModel.fromJson(Map<String,dynamic> json)
  {
    // id =json['id'];
    // name =json['name'];
    message=json['message'];
  }
}