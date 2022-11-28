import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? formattedStartDate;
  String? formattedEndDate;
  double amount = 0;

  TextEditingController daysController = TextEditingController()..text = '0';
  TextEditingController payController = TextEditingController()..text = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HR Portal'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'SALARY CALCULATION',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('Start Date: '),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(formattedStartDate == null
                        ? 'SELECT DATE'
                        : '$formattedStartDate'),
                  ),
                ),
                onTap: () {
                  selectedStartDate ??= DateTime.now();
                  _pickDate(
                      context: context,
                      selectedDate: selectedStartDate!,
                      dateType: 'startDate');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text('End Date: '),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(formattedEndDate == null
                        ? 'SELECT DATE'
                        : '$formattedEndDate'),
                  ),
                ),
                onTap: () {
                  selectedEndDate ??= DateTime.now();
                  _pickDate(
                      context: context,
                      selectedDate: selectedEndDate!,
                      dateType: 'endDate');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Per day pay amount: '),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: payController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('No.of leave days: '),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: daysController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Payable Amount: '),
                  amount == 0
                      ? Text(amount.toString())
                      : Text(
                          amount.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: selectedStartDate == null ||
                          selectedEndDate == null
                      ? null
                      : () {
                          String dateTime = '2022-11-02 00:00:00.000';
                          // calculateSalary(DateTime.parse(dateTime), DateTime.now());
                          calculateSalary(selectedStartDate!, selectedEndDate!);
                        },
                  child: const Text('CALCULATE'))
            ],
          ),
        ),
      ),
    );
  }

  calculateSalary(DateTime startDate, DateTime endDate) {
    String payDays = endDate.difference(startDate).inDays.toString();
    amount = (double.parse(payDays) + 1 - double.parse(daysController.text)) *
        double.parse(payController.text);
    setState(() {});
  }

  _pickDate({
    required BuildContext context,
    required DateTime selectedDate,
    required String dateType,
  }) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      {
        var parsedDate = DateTime.parse(picked.toString());
        if (dateType == 'startDate') {
          selectedStartDate = picked;
          formattedStartDate = DateFormat('dd-MM-yyyy').format(parsedDate);
        } else if (dateType == 'endDate') {
          selectedEndDate = picked;
          formattedEndDate = DateFormat('dd-MM-yyyy').format(parsedDate);
        }
        // selectedStartDate = parsedDate;
      }
    }
    setState(() {});
  }
}
