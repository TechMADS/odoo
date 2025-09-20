import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:editable/editable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/data_file.dart';
import 'admin_screen.dart';
import 'login_screen.dart';
import 'package:mobile/Components/Colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // States
  String? _username;
  String? selectedSubcategory;
  int selectedIndex = 0;

  // CONTROLLER
  final ScrollController _scrollController = ScrollController();
  bool _extend = false;


  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // load Profile Data
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  // LOGOUT
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // GETTING USER NAME
  Future<String> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Guest';
  }

  // ADD ROW
  void addRow() {
    setState(() {
      Map<String, dynamic> newRow = {};
      for (var col in GetData.columns) {
        newRow[col['key']!] = '';
      }
      GetData.rows.add(newRow);
    });
  }

  // ADD COLUMN
  void addColumn() {
    setState(() {
      String newKey = 'col${GetData.columns.length}';
      GetData.columns.add({
        'title': 'Column ${GetData.columns.length + 1}',
        'key': newKey,
        'widthFactor': 0.2,
      });
      for (var row in GetData.rows) {
        row[newKey] = '';
      }
    });
  }

  void saveData() async {
    log("before post");
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/data/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'dept': GetData.departments[selectedIndex],
        'sub': selectedSubcategory,
        'data': GetData.rows,
      }),
    );
    log("after post");
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved Successfully")),
      );
    }
  }

  // FETCHING TABLE DATA
  void fetchTableData(String department, String subcategory) async {
    final response = await http.get(Uri.parse('http://localhost:3000/data?dept=$department&sub=$subcategory'));
    if (response.statusCode == 200) {
      final List<dynamic> fetchedRows = jsonDecode(response.body);
      setState(() {
        GetData.rows = List<Map<String, dynamic>>.from(fetchedRows);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = _username?.toLowerCase() == 'admin';

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("data"),
      // ),
      floatingActionButton: isAdmin ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminPage()
              )
          );
        },
        backgroundColor: Colors.white,
        tooltip: "Go to Admin Page",
        child: const Icon(Icons.admin_panel_settings),
      ) : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppTheme.c2,AppTheme.c1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)
              ),
                child: NavigationRail(
                  backgroundColor: Colors.transparent,
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      selectedIndex = index;
                      selectedSubcategory = null;
                    });
                  },
                  extended: _extend,
                  leading: FutureBuilder<String>(
                    future: _getUsername(),
                    builder: (context, snapshot) {
                      final username = snapshot.data ?? '';
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 16),
                          const CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  trailing: IconButton(onPressed: (){
                    setState(() {
                      _extend = !_extend;
                    });
                  }, tooltip: _extend? " Tap to Close": "Tap to Expand ",
                      icon: Icon(_extend? Icons.close_fullscreen_sharp: Icons.open_in_full, color: Colors.red,)),
                  selectedIconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 28
                  ),
                  selectedLabelTextStyle: const TextStyle(
                      color: Color(0xFF032140),
                      fontWeight: FontWeight.bold
                  ),
                  indicatorColor: Color(0xFF032140),
                  unselectedIconTheme: const IconThemeData(
                      color: Colors.white
                  ),
                  unselectedLabelTextStyle: const TextStyle(
                      color: Colors.white
                  ),
                  destinations: List.generate( GetData.departments.length, (index) {
                    return NavigationRailDestination(
                      icon: Icon(GetData.deptIcons[index]),
                      label: Text(GetData.departments[index]),
                    );
                  }),
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    // 1. Name Of The Department
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [AppTheme.c2,AppTheme.c1]),
                      ),

                      width: double.infinity,

                      alignment: Alignment.center,
                      child:
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 36),
                          children: [
                            TextSpan(
                              text: GetData.departments[selectedIndex].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' DEPARTMENT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),


                    ),

                    // 2. Control Buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white70),
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(colors: [AppTheme.c2,AppTheme.c1])
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: GetData.subcategories[GetData.departments[selectedIndex]]?.contains(selectedSubcategory) == true
                                      ? selectedSubcategory
                                      : null,
                                  hint: const Text(
                                    "Select Subcategory",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  dropdownColor: const Color(0xFF032140),
                                  iconEnabledColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  items: (GetData.subcategories[GetData.departments[selectedIndex]] ?? [])
                                      .map((sub) => DropdownMenuItem(
                                    value: sub,
                                    child: Text(sub),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSubcategory = value;
                                    });
                                    fetchTableData(GetData.departments[selectedIndex], value!);
                                  }
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: addRow,
                                tooltip: "Add Rows",
                                icon: const Icon(Icons.table_rows),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: (){},
                                tooltip: "Delete Rows",
                                icon: const Icon(Icons.delete_sweep),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: addColumn,
                                tooltip: "Add Columns",
                                icon: const Icon(Icons.view_column),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () => {},
                                tooltip: "Delete Columns",
                                icon: const Icon(Icons.delete_forever),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () => {},
                                tooltip: "Undo",
                                icon: const Icon(Icons.undo),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () => {},
                                tooltip: "Redo",
                                icon: const Icon(Icons.redo),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () => {},
                                tooltip: "Graph",
                                icon: const Icon(Icons.trending_up_sharp),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () {log("message");
                                saveData();
                                },
                                tooltip: "Save File",
                                icon: const Icon(Icons.save),
                              ),
                              const SizedBox(width: 10),
                              IconButton.outlined(
                                iconSize: 20,
                                onPressed: () => _logout(context),
                                tooltip: "Log-Out",
                                icon: const Icon(Icons.logout, color: Colors.red,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 3. Data Table
                    Expanded(
                        child: Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth,
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueGrey),
                              ),
                              child: Editable(
                                columns: GetData.columns,
                                rows: GetData.rows,
                                zebraStripe: true,
                                tdStyle: const TextStyle(fontSize: 16),
                                showCreateButton: false,
                                thStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                onRowSaved: (value) {
                                  if (value is Map<String, dynamic>) {
                                    // Try to find a matching row (basic way: assume 'metric' is unique)
                                    int index = GetData.rows.indexWhere((row) => row['metric'] == value['metric']);
                                    if (index != -1) {
                                      GetData.rows[index] = value;
                                      log("Row updated at index $index: ${GetData.rows[index]}");
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
