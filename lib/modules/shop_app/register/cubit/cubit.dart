
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/network/end_points.dart';
import 'package:shop/Shared/network/remote/dio_helper.dart';
import 'package:shop/modules/shop_app/register/cubit/states.dart';
import '../../../Models/ShopApp/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,

  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url:REGISTER,
        data:{
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },).then((value) {
          print(value.data);

          //print(value.data['message']);
          loginModel = ShopLoginModel.fromJson(value.data);
          // print(loginModel?.data?.token);
          // print(loginModel?.message);
          // print(loginModel?.status);
          emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool ispassword=true;

  void changePasswordVisiblity()
  {
    ispassword=!ispassword;
    suffix=ispassword?Icons.visibility_outlined:Icons.visibility_off_outlined;

    emit(ShopegisterChangePasswordVisibilityState());
  }
}