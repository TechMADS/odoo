import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile/Pages/BOM.dart';
import 'package:mobile/Pages/Stock%20ledger.dart';
import 'package:mobile/Pages/homepage.dart';
import 'package:mobile/Pages/work%20center.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/Colors.dart';
import '../Components/ElevationButton.dart';
import '../utils/data_file.dart';
import 'KanbanView.dart';
import 'ManufacturingListView.dart';
import 'ManufacturingOrder.dart';
import 'Settings.dart';
import 'Work order.dart';
import 'admin_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // States
  String? _username;
  final double width = 200;

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
      MaterialPageRoute(builder: (context) => const AuthPage()),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saved Successfully")));
    }
  }

  // FETCHING TABLE DATA
  void fetchTableData(String department, String subcategory) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/data?dept=$department&sub=$subcategory'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> fetchedRows = jsonDecode(response.body);
      setState(() {
        GetData.rows = List<Map<String, dynamic>>.from(fetchedRows);
      });
    }
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return homepage();
      case 1:
        return ManufacturingOrderPage();
      case 2:
        return WorkOrdersPage();
      case 3:
        return Work_Center();
      case 4:
        return StockLedgerPage();
      case 5:
        return BOMPage();
      case 6:
        return settings();

      default:
        return const Center(
          child: Text('Page not found', style: TextStyle(fontSize: 24)),
        );
    }
  }

  Widget getnewbutton(int index) {
    switch (index) {
      case 0:
        return homepagebar();
      case 1:
        return ManufacturingOrderPage();
      case 2:
        // return WorkOrderBar()
      case 4:
        return ledgerbar();
      case 5:
        // return BOM();

      default:
        return const Center(child: Text('', style: TextStyle(fontSize: 24)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isAdmin = _username?.toLowerCase() == 'admin';

    return Scaffold(
      floatingActionButton:
          isAdmin
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminPage()),
                  );
                },
                backgroundColor: Colors.white,
                tooltip: "Go to Admin Page",
                child: const Icon(Icons.admin_panel_settings),
              )
              : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.c2, AppTheme.c1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
                          GestureDetector(
                            onTap:(){Navigator.of(context).pushNamed("/p");},
                            child: const CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.blueAccent,
                              ),
                            ),
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
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _extend = !_extend;
                      });
                    },
                    tooltip: _extend ? " Tap to Close" : "Tap to Expand ",
                    icon: Icon(
                      _extend
                          ? Icons.close_fullscreen_sharp
                          : Icons.open_in_full,
                      color: Colors.red,
                    ),
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: Colors.white,
                    size: 28,
                  ),
                  selectedLabelTextStyle: const TextStyle(
                    color: Color(0xFF032140),
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Color(0xFF032140),
                  unselectedIconTheme: const IconThemeData(color: Colors.white),
                  unselectedLabelTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  destinations: List.generate(GetData.departments.length, (
                    index,
                  ) {
                    return NavigationRailDestination(
                      icon: Icon(GetData.deptIcons[index]),
                      label: Text(GetData.departments[index]),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.c2, AppTheme.c1],
                            ),
                          ),

                          width: double.infinity,

                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 36),
                              children: [
                                TextSpan(
                                  text:
                                      GetData.departments[selectedIndex]
                                          .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' DASHBOARD',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 2. Control Buttons
                        getnewbutton(selectedIndex),
                        getPage(selectedIndex),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResponsiveSearchField extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  final String hintText;
  final Duration debounceDuration;
  final TextEditingController? controller;

  const ResponsiveSearchField({
    Key? key,
    this.onSearch,
    this.hintText = 'Search...',
    this.debounceDuration = const Duration(milliseconds: 350),
    this.controller,
  }) : super(key: key);

  @override
  _ResponsiveSearchFieldState createState() => _ResponsiveSearchFieldState();
}

class _ResponsiveSearchFieldState extends State<ResponsiveSearchField> {
  late final TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      // only dispose if we created it
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    // immediate UI update handled by TextField; debounce for callback
    _debounce?.cancel();
    _debounce = Timer(widget.debounceDuration, () {
      widget.onSearch?.call(_controller.text.trim());
    });
    setState(() {}); // update suffix icon (clear button)
  }

  void _clear() {
    _controller.clear();
    widget.onSearch?.call('');
    setState(() {}); // update suffix icon
  }

  @override
  Widget build(BuildContext context) {
    // Use Expanded so the field is responsive inside a Row.
    return Expanded(
      child: SizedBox(
        height: 48,
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).inputDecorationTheme.fillColor ??
                  Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => widget.onSearch?.call(value.trim()),
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _controller.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _clear,
                        )
                        : null,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class homepagebar extends StatelessWidget {
  const homepagebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white70),
            //   borderRadius: BorderRadius.circular(8),
            //   gradient: LinearGradient(
            //     colors: [AppTheme.c2, AppTheme.c1],
            //   ),
            // ),
            child: GradientElevatedButton(
              text: "New",
              onPressed: () {
                Navigator.of(context).pushNamed("/manufacturing");
              },
            ),
          ),
          const SizedBox(width: 20),
          ResponsiveSearchField(),

          const SizedBox(width: 20),
          Row(
            children: [
              IconButton.outlined(
                iconSize: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManufacturingOrdersPage(),
                    ),
                  );
                },
                tooltip: "Order ListView",
                icon: const Icon(Icons.table_rows),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                iconSize: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManufacturingKanbanPage(),
                    ),
                  );
                },
                tooltip: "Order Kanban View",
                icon: const Icon(Icons.table_rows),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
