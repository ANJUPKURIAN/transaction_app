import 'package:flutter/material.dart';
import 'package:transaction_app/controller/home_screen_controller.dart';
import 'package:transaction_app/core/constant/color_constant.dart';
import 'package:transaction_app/view/home_screen/add_screen/add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await HomeScreenController.getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryblack,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(
            "asset/girl_image.jpg"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Anju",
                style: TextStyle(
                    color: ColorConstants.primarywhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: ColorConstants.primarywhite.withOpacity(0.8),
                  fontSize: 15),
            )
          ],
        ),
        actions: [
          Icon(Icons.segment, color: ColorConstants.primarywhite),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                  color: ColorConstants.primaryblack,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: TextStyle(
                        fontSize: 25,
                        color: ColorConstants.primarywhite.withOpacity(0.6)),
                  ),
                  Text(
                    "\$${HomeScreenController.transactionList.lastOrNull?.balanceAmount ?? "0"}",
                    style: TextStyle(
                        fontSize: 40,
                        color: ColorConstants.primarywhite,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            color: ColorConstants.primarywhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_up,
                                color: ColorConstants.primarygreen,
                                size: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                        color: ColorConstants.primarygreen),
                                  ),
                                  Text(
                                    "\$${HomeScreenController.transactionList.lastOrNull?.totalIncome ?? "0"}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )
                                ],
                              )
                            ]),
                      ),
                      Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            color: ColorConstants.primarywhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_down,
                                color: ColorConstants.primaryred,
                                size: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                        color: ColorConstants.primaryred),
                                  ),
                                  Text(
                                    "\$${HomeScreenController.transactionList.lastOrNull?.totalExpense ?? "0"}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  )
                ],
              ),
            ),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Latest Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Column(
              children: List.generate(
                  HomeScreenController.transactionList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstants.primaryblack
                                      .withOpacity(0.2))),
                          leading: HomeScreenController
                                      .transactionList[index].transactionMode ==
                                  "Income"
                              ? Icon(
                                  Icons.arrow_circle_up,
                                  color: ColorConstants.primarygreen,
                                  size: 40,
                                )
                              : Icon(
                                  Icons.arrow_circle_down,
                                  color: ColorConstants.primaryred,
                                  size: 40,
                                ),
                          title: Text(
                            HomeScreenController.transactionList[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(HomeScreenController
                              .transactionList[index].category),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${HomeScreenController.transactionList[index].amount.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(HomeScreenController
                                  .transactionList[index].date)
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
        },
        backgroundColor: ColorConstants.primaryblack,
        child: Icon(
          Icons.add,
          color: ColorConstants.primarywhite,
        ),
      ),
    );
  }
}