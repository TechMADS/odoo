import 'package:flutter/material.dart';

class GetData {
  static final List<String> departments = [
    'Safety',
    'Production',
    'Finance',
    'Maintenance',
    'Quality',
    'People Development',
    'SCM',
    'WCM',
    'PED'
  ];

  static final Map<String, List<String>> subcategories = {
    'Safety': [
      'SMAT audit',
      'TRIR',
      'Water Consumption',
      'Ltir - Lost Time Incident Rate',
      'Fair - First Aid Incident Rate',
      'Serious Incidents',
      'Recordable Cases',
      'First Aid Cases',
      'Legal Compliance',
      'Water Intensity',
      'Diversion Rate From Landfill (Zwtl)',
      'Total Waste Generated Rate',
      'Haz Waste Intensity',
      '# Env Emergencies And Above',
      '% F Matrix',
      'Legal Compliance'
    ],

    'Production': [
      'Assembly yeild',
      'OEE',
      'Productivity',
      'Scrap',
      'Am Breakdowns',
      'Saoee - Stand Alone Oee',
      'Ole - Overall Line Effectivness',
      'Sole',
      'Cilr Time And Reduction',
      'B/C',
      'Ope - Overall Plant Effectivness',
      'Am Savings',
      'Am Breakdown Losses Eliminated',
      'Backshop Volume',
      'Productivity (Hc, Hpu)',
      'Cleaning Time Reduction',
      'Ftq In - Out',
      'B/C'
    ],

    'Finance': [
      'Conversion cost',
      'P4G',
      'Variable Cost Per Unit',
      'Plant Savings (Hard Savings) - F-Matrix',
      'All Type Of Savings Vs Perimeter',
      'Hpeu',
      'P4G Net',
      'E Matrix Losses Covered By Projects',
      'C Matrix Identified Losses'
    ],

    'Maintenance': [
      'MTTR',
      'MTBF',
      'Energy consumption',
      'Scrap Equipment',
      'Breakdowns Per Machine Per Month',
      'Breakdown Downtime | # Breakdowns (Total & Pm)',
      'Pm Breakdowns After Step 3 | Total Breakdowns After Step 3',
      'Saoee',
      'Defects Per Mold',
      'Msbf',
      'Reliability',
      'Total Breakdown Loss | Pm Breakdown Loss',
      'Eliminated Breakdown Loss',
      'Maintenance Cost',
      'Pm Savings',
      'B/C (Pm Step)  |  B/C (Overall Pm Pillar)',
      'Service Level',
      'Inventory Value',
      'Stock Turns Or Days Of Coverage',
      'Electricity Consumption Pu',
      'Natural Gas Consumption Pu',
      'Ghg Emission',
      'Eng Savings'
    ],

    'Quality': [
      'GSIR',
      'TCQ',
      '1&2 Star',
      'CAL',
      'FPY',
      'SQR',
      'Voc',
      'Sir 1 Mis',
      'Sir  3 Mis R12',
      'Gsir 12 Misa',
      'Tcq',
      'Cost Of Quality (Coq)',
      'Cpm Characteristics (Cc + Hic): Cpk ≥ 1.33',
      'Units On Hold',
      'Scrap'
    ],

    'People Development': [
      'Engagement Pulse Survey',
      'Temps Availability',
      'Temps Consistency',
    ],

    'SCM': [
      'Weekly Actualization',
      'Inventory Days',
      'Daily DTC',
      'Productivity',
      'Ssar',
      'Star',
      'Dtc (Service Level)',
      'Gross Working Capital',
      'Lcpu',
      'Savings In/Out The Perimeter'
    ],

    'WCM': [
      'Plant Savings (Hard Savings) - F-Matrix',
      'B/C Average (Per Kaizen Type)',
      'Focused Projects Savings (Hard Savings)',
      'Plant Savings (Soft Savings)',
      'Focused Projects Savings (Soft Savings)',
      'Total Delay Time Loss',
      'Average Delay Time Loss Per Kaizen',
      'Saving Per Engineer (Hard & Soft)',
      'Actual Cost / Ideal Cost'
    ],

    'PED': [
      'VA - Productivity : Total',
      'HA - Productivity : Total',
      'NPI',
      'Trir Impact | Total Recordable Cases Due To Product Design Root Cause',
      'Ltir Impact | Total First Aid Cases Due To Product Design Root Cause',
      'Total Transformation Cost  |  Direct Material Cost',
      'Total Transformation Cost Savings | Direct Material Cost Savings | Perimeter Cost Savings',
      'Cost Per Unit',
      'Hours Per Equivalent Unit',
      'Total Acquisition Cost',
      'Total Acquisition Cost Savings',
      'Life Cycle Cost Reduction',
      'Gsir 12 Mis',
      'Reactive Design Qa Matrix Ipr',
      'Product Complexity',
      'Trir Impact | Total Recordable Cases During Eem Steps 5-7',
      'Fair Impact | Total First Aid Cases During Eem Steps 5-7',
      'Total Recordable Cases After Sop',
      'Cost Per Unit Impact',
      'Eem Attackable Losses',
      'Eem Savings (From Eem Cd And Cd Attackable Losses)',
      'New Cd Losses',
      'Fpy Impact  |  Fpy After Sop',
      'Sir 1 Mis (After 1St Sellable Unit)',
      'Cpm Characteristics (Cc + Hic): Cpk ≥ 1.33',
      'Dtc Impact (After 1St Sellable Unit)',
      'Line Capacity And Ay Impact',
      'Average Oee At Vsu  |  Average Oee Ytd',
      'Changeover Time',
      'Machine Cycle Time | Or Assembly Takt Time',
      'Muri  |  Golden Zone   (For Projects In Assembly)',
      'Productivity (For Projects In Assembly)',
      'Mtbf At Vsu  |  Mtbf  R6',
      'Project Lead Time (Average And Per Project)',
      'Vertical Start Up (All Time Lowest And Yoy Average) By Project Class',
      'Front Loading (Virtual Best And All Time Cumulative)',
      'Life Cycle Cost  |  Lcc Reduction',
      'Water Intensity Impact After Sop',
      'Total Waste Generated Rate Impact After Sop',
      'Haz Waste Intensity Impact After Sop',
      'Energy Intensity Impact After Sop'
    ],
  };

  static final List<IconData> deptIcons = [
    Icons.health_and_safety,
    Icons.factory,
    Icons.attach_money,
    Icons.handyman,
    Icons.verified,
    Icons.school,
    Icons.local_shipping,
    Icons.speed,
    Icons.design_services,
  ];

  static List<Map<String, dynamic>> rows = [
    // {'metric': 'SMAT audit', 'target': '***', 'ytd': '***', 'mtd': '***', 'wtd': '***'},
    // {'metric': 'TRIR', 'target': '***', 'ytd': '***', 'mtd': '***', 'wtd': '***'},
  ];

  static List<Map<String, dynamic>> columns = [
    {'title': 'Metric', 'key': 'metric', 'widthFactor': 0.3},
    {'title': 'Target 2025', 'key': 'target', 'widthFactor': 0.2},
    {'title': 'Actual YTD', 'key': 'ytd', 'widthFactor': 0.2},
    {'title': 'Actual MTD', 'key': 'mtd', 'widthFactor': 0.2},
    {'title': 'Actual WTD', 'key': 'wtd', 'widthFactor': 0.2},
  ];

}