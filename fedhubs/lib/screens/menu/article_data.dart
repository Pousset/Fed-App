import 'dart:io';

class ArticleData {
  final String name;
  final String price;
  final String description;
  final File? selectedImage; // Add this line
  final String sectionName;

  ArticleData({
    required this.name,
    required this.price,
    required this.description,
    this.selectedImage, // Add this line
    required this.sectionName,
  });
}
