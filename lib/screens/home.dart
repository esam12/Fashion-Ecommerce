import 'package:fashion_ecommerce/data/app_data.dart';
import 'package:fashion_ecommerce/model/base_model.dart';
import 'package:fashion_ecommerce/model/categories_model.dart';
import 'package:fashion_ecommerce/screens/details.dart';
import 'package:fashion_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 2, viewportFraction: 0.7);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  delay: const Duration(microseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Find your",
                              style: theme.headlineLarge,
                              children: [
                                TextSpan(
                                  text: "Style",
                                  style: theme.headlineLarge?.copyWith(
                                    color: primaryColor,
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                        ),
                        RichText(
                          text: const TextSpan(
                              text: "Be more beautiful with our",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "suggestions :)",
                                )
                              ]),
                        ),
                        const SizedBox(height: 10),

                        // Categories
                        FadeInUp(
                          delay: const Duration(milliseconds: 45),
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.15,
                            child: ListView.builder(
                                itemCount: categories.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  CategoriesModel model = categories[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundImage:
                                              AssetImage(model.imageUrl),
                                        ),
                                        SizedBox(height: size.height * 0.008),
                                        Text(
                                          model.title,
                                          style: theme.titleMedium,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),

                        // body
                        FadeInUp(
                          delay: const Duration(milliseconds: 550),
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.45,
                            child: PageView.builder(
                              controller: _controller,
                              physics: const BouncingScrollPhysics(),
                              itemCount: mainList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          data: mainList[index],
                                          isComeFromMostPapularPart: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: view(index, theme, size),
                                );
                              },
                            ),
                          ),
                        ),

                        //Most Popular Text
                        FadeInUp(
                          delay: const Duration(milliseconds: 650),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Most Popular",
                                  style: theme.displaySmall,
                                ),
                                Text(
                                  "See all",
                                  style: theme.headlineMedium,
                                )
                              ],
                            ),
                          ),
                        ),

                        //Most Popular Content
                        FadeInUp(
                          delay: const Duration(milliseconds: 750),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: size.width,
                            height: size.height * 0.44,
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: mainList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.63,
                                ),
                                itemBuilder: (context, index) {
                                  BaseModel data = mainList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Details(
                                            data: mainList[index],
                                            isComeFromMostPapularPart: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Hero(
                                          tag: data.imageUrl,
                                          child: Container(
                                            width: size.width * 0.5,
                                            height: size.height * 0.3,
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                image: DecorationImage(
                                                  image:
                                                      AssetImage(data.imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: Color.fromARGB(
                                                        61, 0, 0, 0),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            data.name,
                                            style: theme.displayMedium,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "€",
                                              style: theme.titleSmall?.copyWith(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: "${data.price}",
                                                  style: theme.titleSmall
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Size size, BaseModel baseModel, TextTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Hero(
            tag: baseModel.id,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: AssetImage(baseModel.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromARGB(61, 0, 0, 0),
                    )
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              baseModel.name,
              style: theme.displayMedium,
            ),
          ),
          RichText(
            text: TextSpan(
                text: "€",
                style: theme.titleSmall?.copyWith(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${baseModel.price}',
                    style: theme.titleSmall?.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: _buildCard(size, mainList[index], theme),
          );
        });
  }
}
