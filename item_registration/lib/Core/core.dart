import 'package:flutter/material.dart';
import 'package:item_registration/Model/item_category_model.dart';
import 'package:item_registration/Model/item_model.dart';

ValueNotifier<List<ItemCategoryModel>> itemCategoryNotifier = ValueNotifier([
  // ItemCategoryModel(itemCategoryID: '1', itemCategoryName: 'Beverages'),
  // ItemCategoryModel(itemCategoryID: '2', itemCategoryName: 'Snacks'),
  // ItemCategoryModel(itemCategoryID: '3', itemCategoryName: 'Dairy'),
]);
ValueNotifier<List<ItemModel>> itemNotifier = ValueNotifier([
  // ItemModel(
  //   itemId: '101',
  //   itemCategoryID: '1',
  //   itemName: 'Coca Cola 500ml',
  //   itemMrp: '40',
  //   itemSaleRate: '35',
  // ),
  // ItemModel(
  //   itemId: '102',
  //   itemCategoryID: '1',
  //   itemName: 'Pepsi 500ml',
  //   itemMrp: '40',
  //   itemSaleRate: '34',
  // ),
  // ItemModel(
  //   itemId: '201',
  //   itemCategoryID: '2',
  //   itemName: 'Lays Classic Salted',
  //   itemMrp: '20',
  //   itemSaleRate: '18',
  // ),
  // ItemModel(
  //   itemId: '202',
  //   itemCategoryID: '2',
  //   itemName: 'Kurkure Masala Munch',
  //   itemMrp: '20',
  //   itemSaleRate: '18',
  // ),
  // ItemModel(
  //   itemId: '301',
  //   itemCategoryID: '3',
  //   itemName: 'Amul Milk 500ml',
  //   itemMrp: '27',
  //   itemSaleRate: '25',
  // ),
  // ItemModel(
  //   itemId: '302',
  //   itemCategoryID: '3',
  //   itemName: 'Cheese Slices (10 pcs)',
  //   itemMrp: '90',
  //   itemSaleRate: '85',
  // ),
]);

String? currentUserId;
