import 'package:animate_do/animate_do.dart';
import 'package:fashion_ecommerce/model/base_model.dart';
import 'package:fashion_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widget/reuseable_button.dart';
import '../widget/reuseable_text.dart';

class Details extends StatefulWidget {
  final BaseModel data;
  final bool isComeFromMostPapularPart;
  const Details(
      {super.key, required this.data, required this.isComeFromMostPapularPart});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  int selectedColor = 2;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            // Product Image
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Stack(children: [
                // Top image
                Hero(
                  tag: widget.isComeFromMostPapularPart
                      ? widget.data.imageUrl
                      : widget.data.id,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.data.imageUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                // gradient
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                )
              ]),
            ),

            // Product Info
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.name,
                            style: theme.displaySmall?.copyWith(fontSize: 23),
                          ),
                          ReUseableTextDetails(
                              text: widget.data.price.toString()),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.data.star.toString(),
                            style: theme.headlineSmall,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${widget.data.review} K+ review",
                            style: theme.displaySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ],
                      ),

                      // Select Size
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 18.0,
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Text(
                            "Select Size",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      // Sizes
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.08,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: sizes.length,
                              itemBuilder: (context, index) {
                                var data = sizes[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.all(10),
                                    duration: const Duration(milliseconds: 200),
                                    width: size.width * 0.12,
                                    decoration: BoxDecoration(
                                        color: selectedSize == index
                                            ? primaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: Center(
                                      child: Text(
                                        data,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: selectedSize == index
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                      // Select Color
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 18.0, left: 10.0, bottom: 10.0),
                          child: Text(
                            "Select Color",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      // Colors
                      FadeInUp(
                        delay: const Duration(milliseconds: 700),
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.08,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                var data = colors[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    margin: const EdgeInsets.all(10),
                                    duration: const Duration(milliseconds: 200),
                                    width: size.width * 0.12,
                                    decoration: BoxDecoration(
                                      color: data,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: selectedColor == index
                                            ? primaryColor
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                      FadeInUp(
                        delay: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.03),
                          child: ReUseableButton(
                            size: size,
                            text: 'Add to cart',
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}
