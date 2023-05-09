import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/Models/ShopApp/ChangeFavoritesModel.dart';
import '../../Shared/Components/constants.dart';
import '../../Shared/network/end_points.dart';
import '../../Shared/network/remote/dio_helper.dart';
import '../../modules/Models/ShopApp/categories_model.dart';
import '../../modules/Models/ShopApp/favorites_model.dart';
import '../../modules/Models/ShopApp/home_model.dart';
import '../../modules/Models/ShopApp/login_model.dart';
import '../../modules/shop_app/categories/categories_screen.dart';
import '../../modules/shop_app/favorites/favorites_screen.dart';
import '../../modules/shop_app/products/produts_screen.dart';
import '../../modules/shop_app/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;

  List<Widget> bottomScreens=
  [
    ProductsScreen(),
    categoriesScreen(),
    favoritessScreen(),
    settingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?,bool?> favorites ={};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value?.data);

      print(homeModel!.data!.banners[0].image.toString());
      print(homeModel!.status.toString());

      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element!.id:element.inFavorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;

  void getCategoriesData()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value?.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    DioHelper.postData(
      url: FAVORITES,
      data: {
      'product_id':productId},
      token: token,
    ).then((value){
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!)
        {
          favorites[productId]=!favorites[productId]!;
        }
      else
        {
          //getFavorites()
        }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId]= !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      //printFullText(value?.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

ShopLoginModel? userModel;

void getUserData()
{
    emit(ShopLoadingUserDataState());

  DioHelper.getData(
    url: PROFILE,
    token: token,
  ).then((value)
  {
    userModel = ShopLoginModel.fromJson(value?.data);
     // printFullText(userModel.data.name);

    emit(ShopSuccessUserDataState(userModel!));
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorUserDataState());
  });
}

  void UpdateUserData({
  @required String? name,
    @required String? email,
    @required String? phone,

  })
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}