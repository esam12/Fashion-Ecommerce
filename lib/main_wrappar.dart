import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:fashion_ecommerce/screens/cart.dart';
import 'package:fashion_ecommerce/screens/home.dart';
import 'package:fashion_ecommerce/screens/search.dart';
import 'package:fashion_ecommerce/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MainWrappar extends StatefulWidget {
  const MainWrappar({super.key});

  @override
  State<MainWrappar> createState() => _MainWrapparState();
}

class _MainWrapparState extends State<MainWrappar> {
  final int _index = 0;
  late bool _isSearchActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _isSearchActive
            ? FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              )
            : FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
          color: Colors.black,
        ),
        actions: [
          _isSearchActive
              ? IconButton(
                  icon: const Icon(LineIcons.searchMinus),
                  onPressed: () {
                    setState(() {
                      _isSearchActive = !_isSearchActive;
                    });
                  },
                  color: Colors.black,
                  iconSize: 30,
                )
              : IconButton(
                  icon: const Icon(
                    LineIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearchActive = !_isSearchActive;
                    });
                  },
                  color: Colors.black,
                  iconSize: 30,
                ),
          IconButton(
            icon: const Icon(
              LineIcons.shoppingBag,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
            },
          ),
        ],
      ),
      body: _isSearchActive ? const Search() : const Home(),
      bottomNavigationBar: BottomBarBubble(
        color: primaryColor,
        selectedIndex: _index,
        items: [
          BottomBarItem(iconData: Icons.home),
          BottomBarItem(iconData: Icons.search),
          BottomBarItem(iconData: Icons.explore),
          BottomBarItem(iconData: Icons.settings),
          BottomBarItem(iconData: Icons.mail),
        ],
        onSelect: (index) {},
      ),
    );
  }
}
