import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:scanner_mobile/src/home/home.dart';
import 'package:scanner_mobile/src/category/category.dart';
import 'package:scanner_mobile/src/image/image.dart';
import 'package:scanner_mobile/src/shared/models/models.dart';

class HomeData extends Equatable {
  const HomeData({
    this.mainCategory,
    this.subCategory,
    this.imageUrl,
  });

  final Category? mainCategory;
  final Category? subCategory;
  final String? imageUrl;

  HomeData copyWith({
    Category? mainCategory,
    Category? subCategory,
    String? imageUrl,
  }) {
    return HomeData(
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [mainCategory, subCategory, imageUrl];
}

List<Page> onGenerateHomePages(HomeData homeData, List<Page> pages) {
  return [
    HomePage.page(),
    if (homeData.mainCategory != null) CategoryPage.page(mainCategory: homeData.mainCategory!),
    if (homeData.mainCategory != null && homeData.subCategory != null)
      CategoryPage.page(
        mainCategory: homeData.mainCategory!,
        subCategory: homeData.subCategory!,
      ),
    if (homeData.imageUrl != null) ImagePage.page(url: homeData.imageUrl!),
  ];
}