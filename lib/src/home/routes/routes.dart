import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:scanner_mobile/src/home/home.dart';
import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/shared/models/models.dart';

class HomeData extends Equatable {
  const HomeData({this.category});

  final Category? category;

  HomeData copyWith({Category? category}) {
    return HomeData(
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [category];
}

List<Page> onGenerateHomePages(HomeData homeData, List<Page> pages) {
  return [
    HomePage.page(),
    if (homeData.category != null) CategoryPage.page(homeData.category!),
  ];
}