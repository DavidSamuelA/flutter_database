import 'package:flutter_database/bank_details.dart';
import 'package:flutter_database/bank_list_screen.dart';
import 'package:flutter_database/database_helper.dart';
import 'package:flutter_database/main.dart';
import 'package:flutter/material.dart';

class EditBankFormScreen extends StatefulWidget {
  const EditBankFormScreen({Key? key}) : super(key: key);

  @override
  State<EditBankFormScreen> createState() => _EditBankFormScreenState();
}

class _EditBankFormScreenState extends State<EditBankFormScreen> {
  var _bankNameController = TextEditingController();
  var _branchController = TextEditingController();
  var _accountTypeController = TextEditingController();
  var _accountNumberController = TextEditingController();
  var _IFSCcodeController = TextEditingController();

  //Edit mode - ##
  bool firstTimeFlag = false;
  int _selectedId = 0;

  _deleteFormDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: false,
    builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {Navigator.pop(context);
                },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
              onPressed: () async {
                final result = await dbHelper.delete(_selectedId, DatabaseHelper.bankDetailsTable);

                debugPrint('----------> Deleted Row Id: $result');

                if (result > 0) {
                  _showSucessSnackBar(context, 'Deleted');
                  Navigator.pop(context);

                  setState(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BankListScreen()));
                  });
                }
              },
              child: const Text('Delete'),
          ),
        ],
        title: const Text('Are you want to delete this'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    //Edit - Receive Data
    if (firstTimeFlag == false) {
      print('-----------> once execute');

      firstTimeFlag = true;

      final bankDetails = ModalRoute.of(context)!.settings.arguments as BankDetails;

      print('--------> Received Data');

      print(bankDetails.id);
      print(bankDetails.bankName);
      print(bankDetails.branch);
      print(bankDetails.accountType);
      print(bankDetails.accountNo);
      print(bankDetails.IFSCcode);

      _selectedId = bankDetails.id!;

      _bankNameController.text = bankDetails.bankName;
      _branchController.text = bankDetails.branch;
      _accountTypeController.text = bankDetails.accountType;
      _accountNumberController.text = bankDetails.accountNo;
      _IFSCcodeController.text = bankDetails.IFSCcode;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account Details Form'),
        actions: [
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(value: 1, child: Text('Delete')),
          ],
            elevation: 2, onSelected: (value) {
            if (value == 1) {
              print('---------> Delete - display dialog');
              _deleteFormDialog(context);
            }
          },
          ),
        ],
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
                  print('-----------> Update Clicked');
                  _update();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _update() async{
    print('--------> _update');

    //Edit
    print('---------> Selected ID: $_selectedId');

    print('---------> BankName: ${_bankNameController.text}');
    print('---------> Branch: ${_branchController.text}');
    print('---------> AccountType: ${_accountTypeController.text}');
    print('---------> AccountNumber: ${_accountNumberController.text}');
    print('---------> IFSCCode: ${_IFSCcodeController.text}');

    Map<String, dynamic> row = {

      DatabaseHelper.columnId: _selectedId,

      DatabaseHelper.columnBankName: _bankNameController.text,
      DatabaseHelper.columnBranch: _branchController.text,
      DatabaseHelper.columnAccountType: _accountTypeController.text,
      DatabaseHelper.columnAccountNo: _accountNumberController.text,
      DatabaseHelper.columnIFSCcode: _IFSCcodeController.text,
    };

    final result = await dbHelper.update(row, DatabaseHelper.bankDetailsTable);

    debugPrint('-------> Updated Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSucessSnackBar (context, 'Updated');
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
