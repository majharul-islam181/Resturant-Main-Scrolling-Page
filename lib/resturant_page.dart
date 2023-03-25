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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
            delegate:
                ResturantCategories(onchanged: (value) {}, selectedIndex: 0),
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
