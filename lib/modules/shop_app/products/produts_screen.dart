import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/Models/ShopApp/home_model.dart';

import '../../../Shared/styles/colors.dart';
import '../../Models/ShopApp/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        // if (state is ShopSuccessChangeFavoritesState)
        //   {
        //     if(!state.model.status)
        //       {
        //         showToast(
        //           text:state.model.message,
        //           state:ToastState.ERROR,
        //         );
        //       }
        //   }
      },
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel!=null &&
              ShopCubit.get(context).categoriesModel!=null ,
          builder:(context)=>
              builderWidget(
                  ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).categoriesModel,context),
          fallback: (context)=>
              Center(
                  child: CircularProgressIndicator()
              ),
        );
      },
    );
  }

  Widget builderWidget(HomeModel? model , CategoriesModel? categorisModel ,context)=>
      SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:model!.data!.banners.map((e) =>
            Image(image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )
          ).toList(),
          options:CarouselOptions(
            height: 250,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1,

          ),
        ),
        SizedBox(
          height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'categories',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800),),
              SizedBox(
                height: 10,),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>
                        buildCategoryItem(
                            categorisModel.data!.data[index],
                            context),
                    separatorBuilder: (context,index)=>
                        SizedBox(width:10,),
                    itemCount: categorisModel!.data!.data.length,
                ),
              ),
              SizedBox(
                height: 10,),
              Text(
                'New Product',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800),),
            ],
          ),
        ),
        SizedBox(
          height: 10,),
        Container(

          child: GridView.count(
            shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.44,

          children:
            List.generate(
            model.data!.products.length,
            (index) => buildGridProduct(
                model.data!.products[index]!,context),
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model ,context)=>
      Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image),
        height:100 ,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100,
        child: Text(
          model.name.toString(),
          textAlign:TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

    ],
  );

  Widget buildGridProduct(ProductModel model,context )=>
      Container(
        color: Colors.white,
        child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
            ),
          if(model.discount!=0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('DISCOUNT',
              style: TextStyle(fontSize: 8,color: Colors.white),),
            ),
  ],
  ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name,
                  maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.1,
                    ),
                  ),
                  Row(
                    children:
                    [
                      Text('${model.price!.round()}',
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
                      if(model.discount!= 0)
                      Text(
                        '${model.oldPrice!.round()}',
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
                           // ShopCubit.get(context).changeFavoritesModel!(model.id);
                            print(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15,
                            backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
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
      );
}
