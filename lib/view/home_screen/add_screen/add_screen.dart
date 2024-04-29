import 'package:transaction_app/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/core/constant/color_constant.dart';
import 'package:transaction_app/view/home_screen/home_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? transaction;
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Record",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Radio(
                            value: "Income",
                            groupValue: transaction,
                            onChanged: (value) {
                              transaction = value;
                              setState(() {});
                            }),
                        Text("Income")
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Radio(
                            value: "Expense",
                            groupValue: transaction,
                            onChanged: (value) {
                              transaction = value;
                              setState(() {});
                            }),
                        Text("Expense")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                    hintText: "Enter Amount",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              SizedBox(height: 10),
              Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide())),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedCategory,
                    hint: Text("Select Category"),
                    items: [
                      DropdownMenuItem(value: "1", child: Text("Food")),
                      DropdownMenuItem(value: "2", child: Text("Personal")),
                      DropdownMenuItem(value: "3", child: Text("Books")),
                      DropdownMenuItem(value: "4", child: Text("Shopping")),
                      DropdownMenuItem(value: "5", child: Text("Income")),

                    ],
                    onChanged: (value) {
                      selectedCategory = value;

                      setState(() {});
                      (() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                    hintText: "Select Date",
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2034));
                          if (selectedDate != null) {
                            String formattedDate =
                                DateFormat('MMMMEEEEd').format(selectedDate);
                            dateController.text = formattedDate.toString();
                          }
                          setState(() {});
                        },
                        icon: Icon(Icons.calendar_month))),
              ),
              SizedBox(height: 10),
              Text(
                "Notes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Enter Notes",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String showCategory = "";
                    if (selectedCategory == "1") {
                      showCategory = "Food";
                    } else if (selectedCategory == "2") {
                      showCategory = "Personal";
                    } else if (selectedCategory == "3") {
                      showCategory = "Books";
                    } else if (selectedCategory =="4"){
                      showCategory = "Shopping";
                    } else{
                      showCategory ="Income";
                    }
                    await HomeScreenController.addDatas(
                        mode: transaction!,
                        title: titleController.text,
                        category: showCategory ?? "",
                        date: dateController.text,
                        amount: int.parse(amountController.text));
                    setState(() {});
                    await HomeScreenController.getDatas();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 120)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStatePropertyAll(ColorConstants.primaryblack)),
                  child: Text(
                    "Add Record",
                    style: TextStyle(color: ColorConstants.primarywhite),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}