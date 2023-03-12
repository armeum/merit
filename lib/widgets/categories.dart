import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:merit_app/dashboard/dashboard.dart';
import 'package:merit_app/models/category.dart';
import 'package:merit_app/order/create_order.dart';
import 'package:merit_app/screens/client/create_client.dart';
import 'package:merit_app/widgets/constants.dart';
import 'package:merit_app/widgets/products_list.dart';

import '../utils/dimensions.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  List<Widget> iconList = [
    const Icon(
      Icons.person,
      size: 80,
      color: Colors.white,
    ),
    const Icon(
      Icons.shopping_cart,
      size: 80,
      color: Colors.white,
    ),
    const Icon(
      Icons.bar_chart_rounded,
      size: 88,
      color: Colors.white,
    )
  ];
  var _currentPageValue = 0.0;
  double height = Dimensions.pageViewContainer;
  final double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (
                context,
                position,
              ) {
                return _buildPageItem(position);
              }),
        ),
        DotsIndicator(
          dotsCount: 3,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: Theme.of(context).primaryColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 700,
          child: ProductList(
            name: 'hhhh',
            code: 'qqqq',
            length: elements.length,
            data: elements,
          ),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    final List<Category> categories = [
      Category(
          id: '1', title: 'Create Client', onPressed: const CreateClient()),
      Category(id: '2', title: 'Create Order', onPressed: const CreateOrder()),
      Category(id: '3', title: 'Dashboard', onPressed: const customDashboard()),
    ];

    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, 220 * (1 - _scaleFactor), 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        Container(
          height: height,
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).primaryColor,
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: const EdgeInsets.only(left: 45, right: 45, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => categories[index].onPressed),
                  )
                },
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(categories[index].title,
                          style: Theme.of(context).textTheme.displayLarge),
                    )),
              ),
            )),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90.0),
              child: iconList[index],
            ),
          ),
        )
      ]),
    );
  }
}
