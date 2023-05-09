class ShopLoginModel
{
 bool? status;
 String? message;
 UserData? data;

 ShopLoginModel.fromJson(Map<String,dynamic> json)
 {
   status= json['status'];
   message= json['message'];
   data= json['data'] != null ?UserData.fromjson(json['data']):null;
 }

}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

//   UserData({
//     this.id,
//     this.email,
//     this.name,
//     this.phone,
//     this.token,
//     this.image,
//     this.credit,
//     this.points,
// });

  //named constructor
  UserData.fromjson(Map<String,dynamic> json)
  {
    id= json['id'];
    name= json['name'];
    phone= json['phone'];
    email= json['email'];
    image= json['image'];
    credit= json['credit'];
    points= json['points'];
    token= json['token'];
  }
}