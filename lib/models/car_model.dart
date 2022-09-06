// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:html';

import 'dart:io';

class CarModel {
  final String? urlImage;
  final File? localimage;
  final double price;
  final String brand;
  final String model;
  final int year;

  CarModel({
    this.localimage,
    this.urlImage,
    required this.price,
    required this.brand,
    required this.model,
    required this.year,
  });

  @override
  String toString() {
    return 'CarModel(image: $urlImage, price: $price, brand: $brand, model: $model, year: $year)';
  }
}
