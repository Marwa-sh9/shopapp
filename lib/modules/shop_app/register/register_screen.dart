
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:shop/Shared/Components/components.dart';
import 'package:shop/Shared/Components/constants.dart';
import 'package:shop/Shared/network/local/cache_helper.dart';
import 'package:shop/Shared/styles/colors.dart';
import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class register_screen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState) {
            if (state.loginModel.status==true) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value) {
                token = state.loginModel.data?.token;
                NavigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });

              ShowToast(
                text:state.loginModel.message,
                state:ToastStates.SUCCESS,
              );
            }
            else {
              print(state.loginModel.message);

              ShowToast(
                text:state.loginModel.message,
                state:ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state){return  Scaffold(
          appBar: AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('REGISTER',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text('register now to browse our hot offers ',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter your  name';
                          }
                        },
                        lable: 'Name',
                        prefixIc: Icons.person,
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your email address';
                            }
                          },
                          lable: 'Email Address',
                          prefixIc: Icons.email_outlined
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffixIc: Icons.visibility_outlined,
                          onSubmit: (value){

                          },
                          ispassword: ShopRegisterCubit.get(context).ispassword  ,
                          onpress: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisiblity();
                          },
                          validate: (String? value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'password is too short';
                            }
                          },
                          lable: 'password',
                          prefixIc: Icons.lock_outline
                      ),
                      SizedBox(height: 15,),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'please enter your phone';
                          }
                        },
                        lable: 'phone',
                        prefixIc: Icons.phone,
                      ),
                      SizedBox(height: 30,),
                      ConditionalBuilder(
                        condition:state is! ShopRegisterLoadingState ,
                        builder: (context)=>
                            defaultButton(
                          color: defaultColor,
                          function: ()
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUppercase: true,
                        ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ); },

      ),
    );
  }
}
