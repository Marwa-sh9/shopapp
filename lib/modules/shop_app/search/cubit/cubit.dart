import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/Components/constants.dart';
import 'package:shop/Shared/network/remote/dio_helper.dart';
import 'package:shop/modules/Models/ShopApp/search_model.dart';
import 'package:shop/modules/shop_app/search/cubit/states.dart';
import '../../../../Shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {

  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
      'text':text,
    },
    ).then((value) {
      model =SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}