import 'package:animate_do/animate_do.dart';
import 'package:fashion_ecommerce/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../data/app_data.dart';
import '../methods/add_to_cart.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    itemsOnSearch = mainList;
  }

  onSearchFunc(String search) {
    setState(() {
      itemsOnSearch = mainList
          .where((element) => element.name.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            // Search TextFiled
            FadeInUp(
              delay: const Duration(milliseconds: 50),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) => onSearchFunc(value),
                    style: textTheme.displaySmall
                        ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              itemsOnSearch = mainList;
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                        hintText: "e.g.Casual Jeans",
                        hintStyle: textTheme.displaySmall?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600])),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: itemsOnSearch.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemsOnSearch.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.63,
                      ),
                      itemBuilder: (context, index) {
                        BaseModel data = itemsOnSearch[index];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index),
                          child: GestureDetector(
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  top: size.height * 0.02,
                                  right: size.height * 0.01,
                                  left: size.height * 0.01,
                                  child: Hero(
                                    tag: data.id,
                                    child: Container(
                                      width: size.width * 0.5,
                                      height: size.height * 0.3,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: DecorationImage(
                                            image: AssetImage(data.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                              color:
                                                  Color.fromARGB(61, 0, 0, 0),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.height * 0.04,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      data.name,
                                      style: textTheme.displayMedium,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: size.height * 0.01,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "€",
                                        style: textTheme.titleSmall?.copyWith(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "${data.price}",
                                            style:
                                                textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: size.height * 0.01,
                                  child: CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          AddToCart.addToCart(data, context);
                                        });
                                      },
                                      icon: const Icon(
                                        LineIcons.addToShoppingCart,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: const Image(
                            image: AssetImage("assets/images/search_fail.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 250),
                          child: const Text(
                            "Not Result Found",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
            )
          ]),
        ),
      ),
    );
  }
}
