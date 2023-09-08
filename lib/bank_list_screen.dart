import 'package:flutter/material.dart';
import 'package:flutter_database/bank_form_screen.dart';
import 'package:flutter_database/database_helper.dart';
import 'package:flutter_database/edit_bank_form_screen.dart';
import 'package:flutter_database/main.dart';
import 'bank_details.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  late List<BankDetails> _bankDetailsList;

  @override
  void initState() {
    super.initState();
    getAllBankDetails();
  }

  getAllBankDetails() async {
    _bankDetailsList = <BankDetails>[];
    var bankDetails =
        await dbHelper.queryAllRows(DatabaseHelper.bankDetailsTable);
    bankDetails.forEach((bankDetail) {
      setState(() {
        print(bankDetail['_id']);
        print(bankDetail['_bankName']);
        print(bankDetail['_branch']);
        print(bankDetail['_accountType']);
        print(bankDetail['_accountNo']);
        print(bankDetail['_IFSCcode']);
        var bankDetailsModel = BankDetails(
          bankDetail['_id'],
          bankDetail['_bankName'],
          bankDetail['_branch'],
          bankDetail['_accountType'],
          bankDetail['_accountNo'],
          bankDetail['_IFSCcode'],
        );
        _bankDetailsList.add(bankDetailsModel);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            new Expanded(
              child: new ListView.builder(
                itemCount: _bankDetailsList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new InkWell(
                    child: ListTile(
                      onTap: () {
                        //Edit
                        print('---------> Edit or Delete invoked: Send Data');

                        print(_bankDetailsList[index].id);
                        print(_bankDetailsList[index].bankName);
                        print(_bankDetailsList[index].branch);
                        print(_bankDetailsList[index].accountType);
                        print(_bankDetailsList[index].accountNo);
                        print(_bankDetailsList[index].IFSCcode);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditBankFormScreen(),
                            settings: RouteSettings(
                                arguments: _bankDetailsList[index])));
                      },
                      title: Text(_bankDetailsList[index].bankName +
                          '\n' +
                          _bankDetailsList[index].branch +
                          '\n' +
                          _bankDetailsList[index].accountType +
                          '\n' +
                          _bankDetailsList[index].accountNo +
                          '\n' +
                          _bankDetailsList[index].IFSCcode),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('----------> FAB Clicked');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BankFormScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
