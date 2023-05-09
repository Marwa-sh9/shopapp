import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/Components/components.dart';
import 'package:shop/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop/modules/shop_app/search/cubit/states.dart';

class searchsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    var searchController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                 defaultFormField(controller: searchController,
                     type: TextInputType.text,
                     validate: (String? value)
                     {
                       if(value!.isEmpty)
                         {
                           return 'enter text to search';
                         }
                       return null;
                     },
                   onSubmit: (String text)
                   {
                     SearchCubit.get(context).search(text);
                   },
                     lable: 'search',
                     prefixIc: Icons.search,
                 ),
                  SizedBox(height: 10,),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder:(context,index)=>
                            buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                        separatorBuilder: (context, index)=>MyDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
