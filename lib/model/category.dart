import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String title;
  final String imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String categoryDescription;

  const Category(
      {required this.categoryId,
      required this.title,
      required this.imageUrl,
      required this.hasSubcategories,
      required this.fullName,
      required this.categoryDescription});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json['categoryId'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        hasSubcategories: json['hasSubcategories'],
        fullName: json['fullName'],
        categoryDescription: json['categoryDescription']);
  }
}
