import 'package:flutter/material.dart';
import 'package:mobile/Components/Colors.dart';

import '../Components/ElevationButton.dart';
import 'Home_Screen.dart';


class StockLedgerPage extends StatefulWidget {
  const StockLedgerPage({super.key});

  @override
  State<StockLedgerPage> createState() => _StockLedgerPageState();
}

class _StockLedgerPageState extends State<StockLedgerPage> {
  List<Map<String, String>> stockData = [
    {
      "product": "Washing Machine",
      "unitCost": "500",
      "unit": "1",
      "totalValue": "500",
      "onHand": "5",
      "freeToUse": "2",
      "incoming": "3",
      "outgoing": "1"
    },
    {
      "product": "Refrigerator",
      "unitCost": "800",
      "unit": "1",
      "totalValue": "800",
      "onHand": "3",
      "freeToUse": "1",
      "incoming": "1",
      "outgoing": "0"
    },
    {
      "product": "Microwave Oven",
      "unitCost": "200",
      "unit": "1",
      "totalValue": "200",
      "onHand": "10",
      "freeToUse": "6",
      "incoming": "2",
      "outgoing": "0"
    },
  ];

  List<Map<String, String>> filteredStock = [];

  @override
  void initState() {
    super.initState();
    filteredStock = List.from(stockData);
  }

  void _openSearchDialog() {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Search Product"),
        content: SizedBox(
          width: 400,
          child: TextField(
            controller: searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter product name",
              suffixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              List<Map<String, String>> results = stockData
                  .where((p) => p["product"]!
                  .toLowerCase()
                  .contains(value.toLowerCase()))
                  .toList();

              Navigator.pop(context); // Close popup automatically

              setState(() {
                if (results.isNotEmpty) {
                  filteredStock = results;
                } else {
                  filteredStock = List.from(stockData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Product not found"),
                        duration: Duration(seconds: 2)),
                  );
                }
              });
            },
          ),
        ),
      ),
    );
  }

  void _addNewProduct(Map<String, String> newProduct) {
    setState(() {
      stockData.add(newProduct);
      filteredStock = List.from(stockData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      // appBar: AppBar(
      //   title: const Text("Stock Ledger"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: _openSearchDialog, icon: const Icon(Icons.search)),
      //     IconButton(onPressed: () {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text("Notifications clicked")),
      //       );
      //     }, icon: const Icon(Icons.notifications)),
      //   ],
      //   leading: TextButton(
      //     onPressed: () async {
      //       final result = await Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => NewProductPage()),
      //       );
      //       if (result != null) {
      //         _addNewProduct(result);
      //       }
      //     },
      //     child: const Text("NEW", style: TextStyle(color: Colors.blueAccent)),
      //   ),
      // ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columnSpacing: 20,
                border: TableBorder.all(color: Colors.grey),
                columns: const [
                  DataColumn(label: Text("Product")),
                  DataColumn(label: Text("Unit Cost")),
                  DataColumn(label: Text("Unit")),
                  DataColumn(label: Text("Total Value")),
                  DataColumn(label: Text("On Hand")),
                  DataColumn(label: Text("Free To Use")),
                  DataColumn(label: Text("Incoming")),
                  DataColumn(label: Text("Outgoing")),
                ],
                rows: filteredStock
                    .map(
                      (product) => DataRow(
                    cells: [
                      DataCell(Text(product["product"]!)),
                      DataCell(Text(product["unitCost"]!)),
                      DataCell(Text(product["unit"]!)),
                      DataCell(Text(product["totalValue"]!)),
                      DataCell(Text(product["onHand"]!)),
                      DataCell(Text(product["freeToUse"]!)),
                      DataCell(Text(product["incoming"]!)),
                      DataCell(Text(product["outgoing"]!)),
                    ],
                  ),
                )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // remove default padding so gradient covers fully
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // rounded corners
                  ),
                  elevation: 4,
                  backgroundColor: Colors.transparent, // needed so gradient is visible
                  shadowColor: Colors.black54,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewProductPage()),
                  );
                  if (result != null) {
                    _addNewProduct(result);
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.c1,AppTheme.c2], // 🌈 gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: const Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // ensure text is visible
                      ),
                    ),
                  ),
                ),
              )

            ),
          ],
        ),

    );
  }
}

class NewProductPage extends StatelessWidget {
  NewProductPage({super.key});

  final TextEditingController productController = TextEditingController();
  final TextEditingController unitCostController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController totalValueController = TextEditingController();
  final TextEditingController onHandController = TextEditingController();
  final TextEditingController freeToUseController = TextEditingController();
  final TextEditingController incomingController = TextEditingController();
  final TextEditingController outgoingController = TextEditingController();

  void _showSavedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Your details have been saved successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildTextField("Product", productController),
            _buildTextField("Unit Cost", unitCostController),
            _buildTextField("Unit", unitController),
            _buildTextField("Total Value", totalValueController),
            _buildTextField("On Hand", onHandController),
            _buildTextField("Free To Use", freeToUseController),
            _buildTextField("Incoming", incomingController),
            _buildTextField("Outgoing", outgoingController),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back")),
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> newProduct = {
                      "product": productController.text,
                      "unitCost": unitCostController.text,
                      "unit": unitController.text,
                      "totalValue": totalValueController.text,
                      "onHand": onHandController.text,
                      "freeToUse": freeToUseController.text,
                      "incoming": incomingController.text,
                      "outgoing": outgoingController.text,
                    };
                    Navigator.pop(context, newProduct);
                    _showSavedPopup(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

class ledgerbar extends StatelessWidget {
  const ledgerbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white70),
              //   borderRadius: BorderRadius.circular(8),
              //   gradient: LinearGradient(
              //     colors: [AppTheme.c2, AppTheme.c1],
              //   ),
              // ),
              child: GradientElevatedButton(text: "New", onPressed: (){})
          ),
          const SizedBox(width: 20),
          ResponsiveSearchField(),

          const SizedBox(width: 20),
          Row(
            children: [
              IconButton.outlined(
                iconSize: 20,
                onPressed: () {},
                tooltip: "Add Rows",
                icon: const Icon(Icons.table_rows),
              ),
              const SizedBox(width: 10),
              IconButton.outlined(
                iconSize: 20,
                onPressed: () {},
                tooltip: "Add Rows",
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
