// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:resturant_main_scrolling_page/component/menu_card.dart';
import 'package:resturant_main_scrolling_page/component/restaruant_categories.dart';
import 'package:resturant_main_scrolling_page/models/menu.dart';

import 'component/restaurant_info.dart';
import 'component/resturant_appbar.dart';

class ResturantPage extends StatefulWidget {
  const ResturantPage({super.key});

  @override
  State<ResturantPage> createState() => _ResturantPageState();
}

class _ResturantPageState extends State<ResturantPage> {
  final scrollcontroller = ScrollController();

  int selectedCategoryIndex = 0;

  double resturantInfoHeight = 200 + 170 - kToolbarHeight;

  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(() {
      // print(scrollcontroller.offset);
      updateCategoryIndexOnScroll(scrollcontroller.offset);
    });

    createBreakPoint();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItem = 0;
      for (var i = 0; i < index; i++) {
        totalItem += demoCategoryMenus[i].items.length;
      }
      scrollcontroller.animateTo(
          // 116 = 100 Menu item height + 16 bottom padding of each item
          // Almost made it, but not perfect
          // 50 + 18 title font size + 32 (16 verical padding on title)
          resturantInfoHeight + (116 * totalItem) + (50 * index),
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    }
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  // Scroll to select category

  List<double> breakPoints = [];
  void createBreakPoint() {
    // 116 = 100 MenuItem Height + 16 button pading of each item
    // 50 = 18 title font size + 32(16 vertical padding on title)
    double firstBreakPoints =
        resturantInfoHeight + 50 + (116 * demoCategoryMenus[0].items.length);
    breakPoints.add(firstBreakPoints);
    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double breakPoint =
          breakPoints.last + 50 + (116 * demoCategoryMenus[i].items.length);
      breakPoints.add(breakPoint);
    }
  }

  // Now we know the break Points

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breakPoints.first) & (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if ((breakPoints[i - 1] <= offset) & (offset < breakPoints[i])) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollcontroller,
        slivers: [
          ResturantAppbar(),
          SliverToBoxAdapter(
            child: RestaurantInfo(),
          ),
          // SliverToBoxAdapter(
          //   child: Categories(
          //     onChanged: (value) {},
          //     selectedIndex: 0,
          //   ),
          // ),

          SliverPersistentHeader(
            delegate: ResturantCategories(
                onchanged: scrollToCategory,
                selectedIndex: selectedCategoryIndex),
            pinned: true,
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              List<Menu> items = demoCategoryMenus[index].items;
              return MenuCategoryItem(
                title: demoCategoryMenus[index].category,
                items: List.generate(
                    items.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: MenuCard(
                              image: items[index].image,
                              title: items[index].title,
                              price: items[index].price),
                        )),
              );
            }, childCount: demoCategoryMenus.length)),
          )
        ],
      ),
    );
  }
}
