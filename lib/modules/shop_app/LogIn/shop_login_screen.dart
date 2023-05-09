import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Shared/network/local/cache_helper.dart';
import 'package:shop/Shared/styles/colors.dart';
import 'package:shop/modules/shop_app/LogIn/cubit/cubit.dart';
import 'package:shop/modules/shop_app/LogIn/cubit/states.dart';
import 'package:shop/modules/shop_app/register/register_screen.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Components/constants.dart';
import '../../../layout/shop_app/shop_layout.dart';

class shoploginscreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create:(BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state)
        {
          if(state is ShopLoginSuccessState) {
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
          builder:(context,state)
          {
            return  Scaffold(
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
                          Text('Login',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text('Login now to browse our hot offers ',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 30,),
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
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              ispassword: ShopLoginCubit.get(context).ispassword  ,
                              onpress: ()
                              {
                                ShopLoginCubit.get(context).changePasswordVisiblity();
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
                          SizedBox(height: 30,),
                          ConditionalBuilder(
                            condition:state is! ShopLoginLoadingState ,
                            builder: (context)=>defaultButton(
                              //width: width,
                              color: defaultColor,
                              function: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },

                              text: 'login',
                              isUppercase: true,
                            ),
                            fallback:(context)=>Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have any account?',),
                              defaultTextButton(
                                function:()
                                {
                                  navigateTo(context,register_screen(),);
                                },
                                text: 'register',
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
