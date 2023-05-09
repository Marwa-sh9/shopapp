import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/network/end_points.dart';
import 'package:shop/Shared/network/remote/dio_helper.dart';
import 'package:shop/modules/shop_app/LogIn/cubit/states.dart';
import '../../../Models/ShopApp/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  @required String? email,
    @required String? password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url:LOGIN,
        data:{
          'email':email,
          'password':password,
        },).then((value) {
          print(value.data);

          //print(value.data['message']);
          loginModel = ShopLoginModel.fromJson(value.data);
          // print(loginModel?.data?.token);
          // print(loginModel?.message);
          // print(loginModel?.status);
          emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool ispassword=true;

  void changePasswordVisiblity()
  {
    ispassword=!ispassword;
    suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}