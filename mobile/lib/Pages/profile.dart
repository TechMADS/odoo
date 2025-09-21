import 'package:flutter/material.dart';



class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Profile fields controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  // Background color animation
  final List<Color> _bgColors = [const Color(0xFF0d426a), const Color(0xFF00a0dc)];
  Color _currentColor = const Color(0xFF0d426a);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChange);

    // Default values
    _nameController.text = "";
    _emailController.text = "";
    _roleController.text = "";
  }

  void _onTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentColor = _tabController.index == 0 ? _bgColors[0] : _bgColors[1];
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: _currentColor,
        width: double.infinity,
        height: double.infinity,
        child: Container(
          width: 10,
          child: Column(
            children: [
              // Tabs
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicator: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  tabs: const [
                    Tab(text: "Profile Page"),
                    Tab(text: "Profile Report"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // -------- Profile Page --------
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ListView(
                        children: [
                          const SizedBox(height: 20),
                          _buildTextField("Name", _nameController),
                          const SizedBox(height: 20),
                          _buildTextField("Email", _emailController),
                          const SizedBox(height: 20),
                          _buildTextField("Role", _roleController),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Profile Saved!")));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: _currentColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Save Profile",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/s");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: _currentColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "Settings",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // -------- Profile Report --------
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView(
                          padding: const EdgeInsets.all(20),
                          children: [
                            const Text(
                              "Profile Report",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Divider(height: 30, thickness: 2, color: Colors.white54),
                            _buildReportRow("Name", _nameController.text),
                            _buildReportRow("Email", _emailController.text),
                            _buildReportRow("Role", _roleController.text),
                            const SizedBox(height: 20),
                            const Text(
                              "Additional Stats",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
                            _buildReportRow("Projects Completed", "12"),
                            _buildReportRow("Hours Logged", "340"),
                            _buildReportRow("Achievements", "5"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildReportRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          Text(value,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}