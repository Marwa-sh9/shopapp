
//GET

//https://newsapi.org/
// v2/top-headlines?
// sources=techcrunch&apiKey=96663b26f9e14968893b8bb8e02abb5f

// https://newsapi.org/
// v2/top-headlines?
// sources=techcrunch&
// apiKey=5e0e80acf5314e6982977f7d3941f81e


//https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=96663b26f9e14968893b8bb8e02abb5f

import 'package:shop/Shared/Components/components.dart';
import 'package:shop/Shared/network/local/cache_helper.dart';
import 'package:shop/modules/shop_app/LogIn/shop_login_screen.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value == true) {
      NavigateAndFinish(context, shoploginscreen(),);
    }
  });
}

void PrintFullText(String text)
{
  final pattern=RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));

}

String? token='';