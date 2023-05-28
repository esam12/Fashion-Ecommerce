import 'package:animate_do/animate_do.dart';
import 'package:fashion_ecommerce/data/app_data.dart';
import 'package:fashion_ecommerce/main_wrappar.dart';
import 'package:fashion_ecommerce/model/base_model.dart';
import 'package:fashion_ecommerce/widget/reuseable_button.dart';
import 'package:fashion_ecommerce/widget/reuseablecartfor_row.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/constants.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // Calculate the total price

  double calculateTotalPrice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0.0;
    } else {
      for (BaseModel data in itemsOnCart) {
        total += data.price * data.value;
      }
    }
    return total;
  }

  //  Calculate the Shipping

  double calculateShippingPrice() {
    double shipping = 0.0;
    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
      return shipping;
    } else if (itemsOnCart.length <= 4) {
      shipping = 5.99;
      return shipping;
    } else {
      shipping = 9.99;
      return shipping;
    }
  }

  // Calculate the sub total price

  int calculateSubTotalPrice() {
    int subTotal = 0;
    if (itemsOnCart.isEmpty) {
      subTotal = 0;
    } else {
      for (BaseModel data in itemsOnCart) {
        subTotal += data.price.round();
        subTotal = subTotal - 160;
      }
    }
    return subTotal < 0 ? 0 : subTotal;
  }

  // delete current selected item from list
  void onDelete(BaseModel data) {
    setState(() {
      if (itemsOnCart.length == 1) {
        itemsOnCart.clear();
      } else {
        itemsOnCart.removeWhere((element) => element.id == data.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: _cartAppBar(context),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.56,
            child: itemsOnCart.isNotEmpty
                ? ListView.builder(
                    itemCount: itemsOnCart.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = itemsOnCart[index];
                      return FadeInUp(
                        delay: Duration(milliseconds: 100 * index + 80),
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          width: size.width,
                          height: size.height * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Container(
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(data.imageUrl),
                                      fit: BoxFit.cover),
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0))
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.52,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              onDelete(data);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "€",
                                          style: theme.titleSmall?.copyWith(
                                            color: primaryColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: data.price.toString(),
                                              style: theme.titleSmall?.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ]),
                                    ),
                                    SizedBox(height: size.height * 0.04),
                                    Text(
                                      "size : ${sizes[3]}",
                                      style: theme.titleSmall?.copyWith(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * 0.04),
                                      width: size.width * 0.4,
                                      height: size.height * 0.04,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    if (data.value > 1) {
                                                      data.value--;
                                                    } else {
                                                      onDelete(data);
                                                      data.value = 1;
                                                    }
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.02),
                                              child: Text(
                                                data.value.toString(),
                                                style: theme.titleSmall
                                                    ?.copyWith(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(4.0),
                                              width: size.width * 0.065,
                                              height: size.height * 0.045,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  setState(() {
                                                    data.value >= 0
                                                        ? data.value++
                                                        : null;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      FadeInUp(
                        child: const Image(
                          image: AssetImage("assets/images/empty.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      FadeInUp(
                        delay: const Duration(milliseconds: 250),
                        child: const Text(
                          "Your cart is empty right now :(",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: IconButton(
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainWrappar()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),

          // Product Price
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.34,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Column(
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 350),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pormo/Student Code or Vourchers",
                            style: theme.displaySmall?.copyWith(fontSize: 16),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: ReUseableCartForRow(
                          text: "Sub Total",
                          price: calculateSubTotalPrice().toDouble()),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 450),
                      child: ReUseableCartForRow(
                          text: "Shipping", price: calculateShippingPrice()),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: ReUseableCartForRow(
                          text: "Total", price: calculateTotalPrice()),
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 550),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ReUseableButton(
                          size: size,
                          text: 'CheckOut',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Cart()),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  AppBar _cartAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "My Cart",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      leading: IconButton(
        color: Colors.black,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          color: Colors.black,
          icon: const Icon(LineIcons.user),
          onPressed: () {},
        )
      ],
    );
  }
}
