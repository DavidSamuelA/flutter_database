import 'package:flutter_database/bank_list_screen.dart';
import 'package:flutter_database/database_helper.dart';
import 'package:flutter_database/main.dart';
import 'package:flutter/material.dart';

class BankFormScreen extends StatefulWidget {
  const BankFormScreen({Key? key}) : super(key: key);

  @override
  State<BankFormScreen> createState() => _BankFormScreenState();
}

class _BankFormScreenState extends State<BankFormScreen> {
  var _bankNameController = TextEditingController();
  var _branchController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNumberController = TextEditingController();
  var _IFSCcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account Details Form'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _bankNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: ('Bank Name'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _branchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: ('Branch'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _accountTypeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: ('Account Type'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _accountNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: ('Account Number'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: TextFormField(
                    controller: _IFSCcodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: ('IFSC Code'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  print('-----------> Save Clicked');
                  _save();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _save() async {
    print('--------> _save');
    print('---------> BankName: ${_bankNameController.text}');
    print('---------> Branch: ${_branchController.text}');
    print('---------> AccountType: ${_accountTypeController.text}');
    print('---------> AccountNumber: ${_accountNumberController.text}');
    print('---------> IFSCCode: ${_IFSCcodeController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.columnBankName: _bankNameController.text,
      DatabaseHelper.columnBranch: _branchController.text,
      DatabaseHelper.columnAccountType: _accountTypeController.text,
      DatabaseHelper.columnAccountNo: _accountNumberController.text,
      DatabaseHelper.columnIFSCcode: _IFSCcodeController.text,
    };

    final result = await dbHelper.insert(row, DatabaseHelper.bankDetailsTable);

    debugPrint('-------> Inserted Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSucessSnackBar (context, 'Saved');
    }

    setState(() {
      Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) => BankListScreen()));
    });
  }
  void _showSucessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
