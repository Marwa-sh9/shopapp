import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Shared/styles/colors.dart';
import 'package:shop/layout/cubit/cubit.dart';

Widget defaultButton({
 @required double width:double.infinity,
 @required Color? color,
 @required Function()? function,
 bool isUppercase :true,
 @required String text:'',
})
=>
Container(
width: width,
color:color,
child: MaterialButton(
onPressed: function,
height: 60.0,
child:Text(
 isUppercase ? text.toUpperCase():text ,
style: TextStyle(
color:Colors.black,
fontSize: 20.0,
fontWeight: FontWeight.bold,
),
),
),
);

Widget defaultTextButton({
 @required Function()? function,
@required String? text,
})=>
    TextButton(
        onPressed: function,
        child:Text(text!.toUpperCase()),
    );

Widget defaultFormField({
 @required TextEditingController ? controller,
 @required TextInputType ? type,
  Function(String)? onSubmit,
  Function(String)? onChange,
 Function()? onpress,
 @required FormFieldValidator<String>? validate,
 // @required Function(String)? validate,
 @required String? lable,
 @required IconData? prefixIc,
 IconData? suffixIc,
  bool ispassword =false,
 Function()? onTap,
 bool isClickable=true,
}) =>
TextFormField(
controller:controller,
keyboardType: type,
 onFieldSubmitted:onSubmit,
 obscureText:ispassword,
onChanged: onChange,
onTap:onTap ,
validator: validate,
enabled:isClickable ,
decoration: InputDecoration(
labelText: lable,
prefixIcon: Icon(
    prefixIc,
),
    suffixIcon:suffixIc!= null ? IconButton(
     onPressed: onpress,
      icon: Icon(
       suffixIc,
      ),
    ):null,
//  border: BorderRadius.circular(),
),
);


Widget MyDivider({
 Color color=Colors.greenAccent,
})=>Padding(
 padding: const EdgeInsets.all(5.0),
 child: Container(
  width: double.infinity,
  height: 1,
  color: color,
 ),
);


void navigateTo(context,widget)=>Navigator.push(
 context,
MaterialPageRoute(builder:(context)=>widget,),
);

void NavigateAndFinish(
    context,widget,
    )=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>widget,),
            (Route<dynamic> route) => false
    );
void ShowToast({
 @required String? text,
 @required ToastStates? state,
})=>Fluttertoast.showToast(
 msg: text.toString(),
 toastLength: Toast.LENGTH_LONG,
 gravity: ToastGravity.BOTTOM,
 timeInSecForIosWeb: 5,
 backgroundColor: chooseToastColor(state!),
 textColor: Colors.white,
 fontSize: 16.0,
);

//enum
enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state)
{
 Color color;
 switch(state)
 {
  case ToastStates.SUCCESS:
  color= Colors.green;
  break;
  case ToastStates.ERROR:
  color= Colors.red;
  break;
  case ToastStates.WARNING:
  color= Colors.amber;
  break;
 }
 return color;
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
       width: 120,
       height: 120,
      ),
      if(model.discount !=0&&isOldPrice)
       Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text('model.discount',
         style: TextStyle(fontSize: 8,color: Colors.white),),
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


