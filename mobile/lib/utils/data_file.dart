import 'package:flutter/material.dart';

class GetData {
  /// Departments / Modules in washing machine manufacturing
  static final List<String> departments = [
    'Dashboard',
    'Manufacturing Orders',
    'Work Orders',
    'Work Centers',
    'Stock Ledger',
    'BOM',

  ];

  /// Subcategories / KPIs per module
  static final Map<String, List<String>> subcategories = {
    'Dashboard': [
      'Real-time Manufacturing Orders List',
      'Component Availability',
      'Filter Orders by Status/State',
      'Quick KPIs: Completed, In-progress, Delayed Orders',
    ],
    'Manufacturing Orders': [
      'Create/Edit/Delete Production Orders',
      'Attach BOMs, Work Centers, Deadlines',
      'Track Progress & Dependencies',
    ],
    'Work Orders': [
      'Assign Tasks to Operators',
      'Track Status Updates (Started, Paused, Completed)',
      'Capture Comments, Issues, Delays',
    ],
    'Work Centers': [
      'Work Center Cost per Hour',
      'Operator Efficiency Monitoring',
    ],
    'Stock Ledger': [
      'Real-time Raw Material & Finished Goods Movement',
      'Automatic Updates after Work Order Completion',
      'Product Creation & Stock Maintenance',
    ],
    'BOM': [
      'Set Material Quantities, Components, and Work Orders',
      'Link BOM to Manufacturing Orders',
    ],
    'Profile & Reports': [
      'My Profile – Update Details & Password',
      'View Completed Work Orders or Tasks',
      'Check Total Work Duration Reports',
    ],
    'Analytics & Features': [
      'Production Throughput Analysis',
      'Order Delay Tracking',
      'Resource Utilization Overview',
      'Exportable Reports (Excel/PDF)',
      'Scalable for Future Modules: Quality Check, Maintenance',
    ],
  };

  /// Icons for departments (for drawer & dashboards)
  static final List<IconData> deptIcons = [
    Icons.dashboard, // Dashboard
    Icons.precision_manufacturing, // Manufacturing Orders
    Icons.assignment_ind, // Work Orders
    Icons.build_circle, // Work Centers
    Icons.inventory, // Stock Ledger
    Icons.article, // BOM
    Icons.settings, // Profile & Reports
    Icons.analytics, // Analytics & Features
  ];

  /// Example KPI rows
  static List<Map<String, dynamic>> rows = [
    {
      'metric': 'Assembly Yield',
      'target': '98%',
      'ytd': '96.8%',
      'mtd': '97.2%',
      'wtd': '97.5%'
    },
    {
      'metric': 'First Pass Quality (FPQ)',
      'target': '99%',
      'ytd': '98.1%',
      'mtd': '98.5%',
      'wtd': '98.7%'
    },
    {
      'metric': 'Production Orders Completed',
      'target': '1000 / month',
      'ytd': '950',
      'mtd': '80',
      'wtd': '20'
    },
    {
      'metric': 'Component Stock Accuracy',
      'target': '99%',
      'ytd': '97.5%',
      'mtd': '98%',
      'wtd': '98.2%'
    },
  ];

  /// Table column structure
  static List<Map<String, dynamic>> columns = [
    {'title': 'Metric', 'key': 'metric', 'widthFactor': 0.35},
    {'title': 'Target', 'key': 'target', 'widthFactor': 0.2},
    {'title': 'YTD', 'key': 'ytd', 'widthFactor': 0.15},
    {'title': 'MTD', 'key': 'mtd', 'widthFactor': 0.15},
    {'title': 'WTD', 'key': 'wtd', 'widthFactor': 0.15},
  ];
}
