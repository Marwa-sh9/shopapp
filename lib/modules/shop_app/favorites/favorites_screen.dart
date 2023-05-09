import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/Models/ShopApp/favorites_model.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/styles/colors.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';

class favoritessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
              itemBuilder:(context,index)=>
                  buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              separatorBuilder: (context, index)=>MyDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget buildListProduct(
      model,
      context,
      {bool isOldPrice=true})
  =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    fit: BoxFit.cover,
                    width: 110,
                    height: 120,
                  ),
                  if(model.discount !=0 && isOldPrice)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5
                      ),
                      child: Text('model.discount',
                        style: TextStyle(
                            fontSize: 8,
                            color: Colors.white
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.1,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children:
                      [
                        Text(model.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if(model.discount!= 0 && isOldPrice)
                          Text(
                            model.oldprice.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: ()
                          {
                            ShopCubit.get(context).changeFavorites(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            // backgroundColor:
                            //
                            //  ShopCubit.get(context).favorites[model.id]
                            //     ? defaultColor
                            //     : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
