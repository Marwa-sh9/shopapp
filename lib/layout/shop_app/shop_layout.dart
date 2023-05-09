import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/network/local/cache_helper.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/shop_app/LogIn/shop_login_screen.dart';
import 'package:shop/modules/shop_app/search/search_screen.dart';

import '../../Shared/Components/components.dart';
import '../../Shared/Components/constants.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state)
      {
        var cubit=ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla',
            ),
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, searchsScreen(),);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex:cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,),
              label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.apps,),
                label: 'Cateogries',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border,),
                label: 'favorite',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),
                label: 'settings',
              ),
            ],
          ),
        );
      } ,
    );
  }
}
