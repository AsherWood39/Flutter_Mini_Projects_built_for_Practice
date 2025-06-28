import 'package:flutter/material.dart';
import 'package:money_tracker_app_flutter/Model/transaction_model.dart';

ValueNotifier<List<TransactionModel>> myTransactionNotifier = ValueNotifier([
  TransactionModel(
    id: '1',
    transactionNarration: 'Grocery',
    transactionType: '-1',
    transactionAmount: '2000',
  ),
  TransactionModel(
    id: '2',
    transactionNarration: 'Salary',
    transactionType: '+1',
    transactionAmount: '50000',
  ),
  TransactionModel(
    id: '3',
    transactionNarration: 'Electricity Bill',
    transactionType: '-1',
    transactionAmount: '3445',
  ),
  TransactionModel(
    id: '4',
    transactionNarration: 'Freelance Project',
    transactionType: '+1',
    transactionAmount: '1569',
  ),
  TransactionModel(
    id: '5',
    transactionNarration: 'Restaurant',
    transactionType: '-1',
    transactionAmount: '700',
  ),
  TransactionModel(
    id: '6',
    transactionNarration: 'Stock Dividend',
    transactionType: '+1',
    transactionAmount: '20000',
  ),
  TransactionModel(
    id: '7',
    transactionNarration: 'Online Shopping',
    transactionType: '-1',
    transactionAmount: '5089',
  ),
  TransactionModel(
    id: '8',
    transactionNarration: 'Interest Income',
    transactionType: '+1',
    transactionAmount: '15678',
  ),
  TransactionModel(
    id: '9',
    transactionNarration: 'Movie Ticket',
    transactionType: '-1',
    transactionAmount: '960',
  ),
  TransactionModel(
      id: '10',
      transactionNarration: 'Gift Received',
      transactionType: '+1',
      transactionAmount: '5000'),
]);
