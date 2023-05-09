import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bloc/bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/network/local/cache_helper.dart';
import 'Shared/network/remote/dio_helper.dart';
import 'Shared/styles/themes.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/LogIn/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';


void main() async
{
  //بيتأكد من كل الميثودات بعدين بيفتح التطبيق
   WidgetsFlutterBinding.ensureInitialized();

   Bloc.observer = MyBlocObserver();
   DioHelper.init();
   await CacheHelper.init();

   bool isDark = CacheHelper.getData(key: 'isDark');

   Widget widget;

   bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   String token=CacheHelper.getData(key: 'token');

   if(onBoarding !=null) {
     if (token == null)
       widget = ShopLayout();
     else
       widget = shoploginscreen();
   }
   else
     {
       widget=OnBoardingScreen();
     }

   runApp(MyApp(
     widget,
   ));
}
class MyApp extends StatelessWidget {

  //final bool isDark;
  final Widget statrwidget;

  //MyApp(this.isDark);
  MyApp(this.statrwidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>
        ShopCubit()..getHomeData()..getCategoriesData()..getUserData(),
        ),
      ],
      child: MaterialApp (
        debugShowCheckedModeBanner: false,
        //start
        theme: lightTheme,
        // themeMode: AppCubit.get(context).isDark?ThemeMode.light:ThemeMode.dark,
        // darkTheme: darkTheme,
        home:statrwidget,
      ),
    );
  }
}
