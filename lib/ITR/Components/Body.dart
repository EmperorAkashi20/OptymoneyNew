import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optymoney/Components/inputwithicon.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _itr = false;
  bool _ebill = false;
  bool _deposit = false;
  bool _foreignTravel = false;
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _loadingPath = false;
  FileType _pickingType = FileType.any;
  bool _multiPick = true;
  TextEditingController _controller = TextEditingController();
  int _itemcountItr = 0;
  int _itemcountNoticeCopy = 0;
  int _itemcountLastItr = 0;
  int _itemcountOtherAttachments = 0;
  int _itemcount = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths!.first.extension);
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });
  }

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                "Financial Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InputWithIcon(
                icon: Icons.wrap_text_outlined,
                hint: 'Bank Name',
                obscureText: false,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InputWithIcon(
                icon: Icons.wrap_text_outlined,
                hint: 'Account Number',
                obscureText: false,
                keyboardTypeGlobal: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InputWithIcon(
                icon: Icons.wrap_text_outlined,
                hint: 'IFSC Code',
                obscureText: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ITR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 50.0),
                    child: Switch.adaptive(
                      value: _itr,
                      onChanged: (bool value) {
                        setState(() {
                          _itr = value;
                          print(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "E-Assessment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (_itr == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3594DD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            child: Text(
                              "Form 16/16A",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Number Of Files Selected: " +
                                _itemcount.toString(),
                            style: TextStyle(
                                color: Color(0xFFB40284A), fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3594DD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            child: Text(
                              "Other Attachments",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Number Of Files Selected: " +
                                _itemcount.toString(),
                            style: TextStyle(
                                color: Color(0xFFB40284A), fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (_itr == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3594DD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            child: Text(
                              "Notice Copy",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Number Of Files Selected: " +
                                _itemcount.toString(),
                            style: TextStyle(
                                color: Color(0xFFB40284A), fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3594DD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            child: Text(
                              "Last ITR Filed",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Number Of Files Selected: " +
                                _itemcount.toString(),
                            style: TextStyle(
                                color: Color(0xFFB40284A), fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF3594DD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _openFileExplorer();
                            },
                            child: Text(
                              "Other Attachments",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Number Of Files Selected: " +
                                _itemcount.toString(),
                            style: TextStyle(
                                color: Color(0xFFB40284A), fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SwitchListTile.adaptive(
              title: Text("Does your total deposists exceed 1Cr?"),
              value: _deposit,
              onChanged: (bool value) {
                setState(() {
                  _deposit = value;
                });
              },
            ),
            SwitchListTile.adaptive(
              title:
                  Text("Does your total electricity charges exceed Rs. 1Lakh?"),
              value: _ebill,
              onChanged: (bool value) {
                setState(() {
                  _ebill = value;
                });
              },
            ),
            SwitchListTile.adaptive(
              title: Text(
                  "Foreign Travel expenses for self or other person in family exceeds Rs. 2Lakhs?"),
              value: _foreignTravel,
              onChanged: (bool value) {
                setState(() {
                  _foreignTravel = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (_itemcount > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3594DD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _clearCachedFiles();
                      },
                      child: Text(
                        "Clear Cached Files",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            Builder(
              builder: (BuildContext context) => _loadingPath
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const CircularProgressIndicator(),
                    )
                  : _directoryPath != null
                      ? ListTile(
                          title: const Text('Directory path'),
                          subtitle: Text(_directoryPath!),
                        )
                      : _paths != null
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: Scrollbar(
                                child: ListView.separated(
                                  itemCount:
                                      _paths != null && _paths!.isNotEmpty
                                          ? _paths!.length
                                          : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    _itemcount =
                                        _paths != null && _paths!.isNotEmpty
                                            ? _paths!.length
                                            : 1;
                                    print(_itemcount);
                                    final bool isMultiPath =
                                        _paths != null && _paths!.isNotEmpty;
                                    final String name = 'File $index: ' +
                                        (isMultiPath
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...');
                                    final path = _paths!
                                        .map((e) => e.path)
                                        .toList()[index]
                                        .toString();

                                    return ListTile(
                                      title: Text(
                                        name,
                                      ),
                                      subtitle: Text(path),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                ),
                              ),
                            )
                          : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
