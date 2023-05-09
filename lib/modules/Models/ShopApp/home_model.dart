class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status =json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{

  // final Map<String, dynamic> jsonResult = jsonDecode(response.body);
  //
  // List<Dolar> dolar  =  (jsonResult['USDBRL']
  // as List<dynamic>)
  //     .map((data) => Dolar.fromJson(data))
  //     .toList();

  List<BannerModel> banners=[];
  List<ProductModel?> products=[];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}
class BannerModel
{
  int? id;
  String? image;
  BannerModel({
   required this.id,
    required this.image,
});
 factory BannerModel.fromJson(Map<dynamic,dynamic> json)
  {
    return BannerModel(
    id:json['id'],
    image:json['image'],);
  }
}

class ProductModel
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image='';
  String name='';
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<dynamic, dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}