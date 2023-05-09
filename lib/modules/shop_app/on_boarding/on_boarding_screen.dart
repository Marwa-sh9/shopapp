
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Shared/Components/components.dart';
import 'package:shop/Shared/network/local/cache_helper.dart';
import 'package:shop/Shared/styles/colors.dart';
import 'package:shop/modules/shop_app/LogIn/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    @required this.title,
    @required this.image,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController =PageController();

  List<BoardingModel> boarding=
  [
    BoardingModel(
        title: 'On Board 1 title',
        image: 'assets/shopImage/a.jpg',
        body: 'On Board 1 body'
    ),
    BoardingModel(
        title: 'On Board 2 title',
        image: 'assets/shopImage/a.jpg',
        body: 'On Board 2 body'
    ),
    BoardingModel(
        title: 'On Board 3 title',
        image: 'assets/shopImage/a.jpg',
        body: 'On Board 3 body'
    ),
  ];
  bool isLast=false;

  void submit()
  {
    CacheHelper.saveData(
    key: 'onBoarding',
    value: true).then((value)
    {
      if (value==true)
      {
        NavigateAndFinish(context, shoploginscreen(),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function:submit,
            text: 'skip',

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                    {
                      setState(()
                      {
                        isLast=true;
                      });
                     // print('last');
                    } else
                      {
                        //print('not last');
                        setState(()
                        {
                          isLast=false;
                        });
                      }
                },
                controller: boardController,
                itemBuilder:(context,index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      activeDotColor: HexColor('F5EA8C'),
                      spacing: 5,

                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed:() {
                    if(isLast){
                      submit();
                    }
                    else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                child: Icon(
                  //color: Color(0xffad8af1),
                    Icons.arrow_forward_ios,
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),

        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(
        height: 10,
      ),

    ],
  );
}
