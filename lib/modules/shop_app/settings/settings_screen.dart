import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Shared/Components/constants.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import '../../../Shared/Components/components.dart';

class settingsScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var PhoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        PhoneController.text=model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel!=null,
          builder:(context)=> Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value)
                    {
                      if(value!.isEmpty )
                      {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    lable: 'Name',
                    prefixIc: Icons.person,
                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String? value)
                    {
                      if(value!.isEmpty )
                      {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    lable: 'Email',
                    prefixIc: Icons.email,
                  ),
                  SizedBox(height: 20,),
                  defaultFormField(
                    controller: PhoneController,
                    type: TextInputType.phone,
                    validate: (String? value)
                    {
                      if(value!.isEmpty )
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    lable: 'Phone',
                    prefixIc: Icons.phone,
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                    function:()
                    {
                      if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).UpdateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: PhoneController.text,
                          );
                        }
                    },
                    text: 'update',
                  ),
                  SizedBox(height: 20,),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'LogOut')
                ],
              ),
            ),
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
      );
  }
}
