import 'package:flutter/material.dart';

class CategoryTileComponent extends StatelessWidget {
  final String name;
  final CategoryType categoryType;
  final String imageUrl;
  final Function(CategoryType) onTap;

  const CategoryTileComponent({ 
    Key? key, 
    required this.name,
    required this.categoryType,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(categoryType),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

enum CategoryType {
  rock,
  pop,
  electronic,
  rap,
  funk,
  international,
  techno,
  news,
}