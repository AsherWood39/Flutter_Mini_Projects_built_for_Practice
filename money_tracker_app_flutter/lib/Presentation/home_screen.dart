// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:money_tracker_app_flutter/Core/core.dart';
import 'package:money_tracker_app_flutter/Model/transaction_model.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final narrationController = TextEditingController();
  final amountController = TextEditingController();
  final List<String> transactionTypes = [
    'Income',
    'Expense',
  ];
  String? selectedType;

  final editNarrationController = TextEditingController();
  final editAmountController = TextEditingController();
  String? editSelectedType;

  void addTransaction(String narration, String type, String amount) {
    myTransactionNotifier.value.add(TransactionModel(
        id: (myTransactionNotifier.value.length + 1).toString(),
        transactionNarration: narration,
        transactionType: type,
        transactionAmount: amount));
  }

  void editTransaction(
      int? index, String narration, String type, String amount) {
    myTransactionNotifier.value[index!].transactionNarration = narration;
    myTransactionNotifier.value[index].transactionAmount = amount;
    myTransactionNotifier.value[index].transactionType = type;
  }

  void removeTransaction(int index) {
    myTransactionNotifier.value.removeAt(index);
    for (int i = index; i < myTransactionNotifier.value.length - 1; i++) {
      myTransactionNotifier.value[i].id = myTransactionNotifier.value[i + 1].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1565C0),
          title: const Text(
            'Money Tracker',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ValueListenableBuilder(
              valueListenable: myTransactionNotifier,
              builder: (context, value, _) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var transactionData = value[index];
                      return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: const Color(0xFF1565C0),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                    color: Color(0xFFFFB300),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              )),
                          title: Text(
                            transactionData.transactionNarration,
                            style: const TextStyle(
                                color: Color(0xFF212121),
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          subtitle: Text(
                            'Rs. ${transactionData.transactionAmount}',
                            style: const TextStyle(color: Color(0xFFD32F2F)),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  final transactionData = value[index];

                                  editNarrationController.text =
                                      transactionData.transactionNarration;
                                  editAmountController.text =
                                      transactionData.transactionAmount;
                                  editSelectedType =
                                      transactionData.transactionType == '+1'
                                          ? 'Income'
                                          : 'Expense';
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext editContext) {
                                        return AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              'Edit Transaction',
                                              style: TextStyle(
                                                  color: Color(0xFFD32F2F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        editNarrationController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Transaction Narrator is Required';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                        hintText: 'Narration'),
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        editAmountController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Transaction Amount is Required';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6)),
                                                        hintText: 'Amount'),
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  DropdownButtonFormField<
                                                          String>(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Transaction Type is Required';
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                ), // Bottom border color and thickness
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xFF1565C0)),
                                                              )),
                                                      hint: const Text(
                                                          'Transaction Type'),
                                                      onChanged: (newValue) {
                                                        editSelectedType =
                                                            newValue!;
                                                      },
                                                      items: transactionTypes
                                                          .map((type) {
                                                        return DropdownMenuItem(
                                                            value: type,
                                                            child: Text(type));
                                                      }).toList()),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    editContext)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              String narration =
                                                                  editNarrationController
                                                                      .text;
                                                              String amount =
                                                                  editAmountController
                                                                      .text;
                                                              String type =
                                                                  editSelectedType ==
                                                                          'Income'
                                                                      ? '+1'
                                                                      : '-1';

                                                              editTransaction(
                                                                  index,
                                                                  narration,
                                                                  type,
                                                                  amount);

                                                              myTransactionNotifier
                                                                  .notifyListeners();

                                                              editNarrationController
                                                                  .clear();
                                                              editAmountController
                                                                  .clear();
                                                              editSelectedType =
                                                                  null;

                                                              Navigator.of(
                                                                      editContext)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Save'))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20.0,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext alertContext) {
                                        return AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              'Are you sure about this?',
                                              style: TextStyle(
                                                  color: Color(0xFFD32F2F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(alertContext)
                                                          .pop();
                                                    },
                                                    child: const Text('No')),
                                                TextButton(
                                                    onPressed: () {
                                                      removeTransaction(index);

                                                      myTransactionNotifier
                                                          .notifyListeners();

                                                      Navigator.of(alertContext)
                                                          .pop();
                                                    },
                                                    child: const Text('Yes'))
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20.0,
                                  color: Color(0xFFD32F2F),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              )
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: myTransactionNotifier.value.length);
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext addContext) {
                  return AlertDialog(
                    title: const Center(
                      child: Text(
                        'Add a Transaction',
                        style: TextStyle(
                            color: Color(0xFFD32F2F),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: narrationController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Transaction Narrator is Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  hintText: 'Narration'),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: amountController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Transaction Amount is Required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  hintText: 'Amount'),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Transaction Type is Required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ), // Bottom border color and thickness
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF1565C0)),
                                    )),
                                hint: const Text('Transaction Type'),
                                onChanged: (newValue) {
                                  selectedType = newValue!;
                                },
                                items: transactionTypes.map((type) {
                                  return DropdownMenuItem(
                                      value: type, child: Text(type));
                                }).toList()),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      narrationController.clear();
                                      amountController.clear();
                                      selectedType = null;

                                      Navigator.of(addContext).pop();
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String narration =
                                            narrationController.text;
                                        String amount = amountController.text;
                                        String type = selectedType == 'Income'
                                            ? '+1'
                                            : '-1';

                                        addTransaction(narration, type, amount);

                                        myTransactionNotifier.notifyListeners();

                                        narrationController.clear();
                                        amountController.clear();
                                        selectedType = null;

                                        Navigator.of(addContext).pop();
                                      }
                                    },
                                    child: const Text('Add')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          backgroundColor: const Color(0xFF1565C0),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
