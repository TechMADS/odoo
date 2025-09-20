import 'package:flutter/material.dart';
// import 'package:wcm/utils/auth_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // You can customize departments or fetch them dynamically
  final List<String> _departments = [
    'Safety',
    'Production',
    'Finance',
    'Maintenance',
    'Quality',
    'People Development',
    'SCM',
    'WCM',
    'PED',
  ];

  String? _selectedDept;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate() || _selectedDept == null) {
      setState(() {
        _errorMessage = 'Please fill all fields correctly';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final dept = _selectedDept!;

    // try {
    //   final response = await AuthService.register(username, password, dept);
    //
    //   if (response.containsKey('message')) {
    //     // Assuming backend sends success message or error message in 'message' key
    //     final message = response['message'];
    //     if (message.toString().toLowerCase().contains('success')) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('User created successfully!')),
    //       );
    //       _formKey.currentState!.reset();
    //       _usernameController.clear();
    //       _passwordController.clear();
    //       setState(() {
    //         _selectedDept = null;
    //       });
    //     } else {
    //       setState(() {
    //         _errorMessage = message;
    //       });
    //     }
    //   } else {
    //     setState(() {
    //       _errorMessage = 'Unexpected server response.';
    //     });
    //   }
    // } catch (e) {
    //   setState(() {
    //     _errorMessage = 'Failed to create user: $e';
    //   });
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Admin Panel - Create User'),
      //   backgroundColor: Colors.transparent,
      // ),
      body:Stack(
        children:[ Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/desk_bg.png"),fit: BoxFit.cover)
          ),

          child: Center(
            child: Container(
              width: 370,
              height: 370,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16)
              ),
              padding: EdgeInsets.all(26.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          (value == null || value.isEmpty) ? 'Enter username' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          (value == null || value.isEmpty) ? 'Enter password' : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Department',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedDept,
                          items: _departments
                              .map((dept) =>
                              DropdownMenuItem(value: dept, child: Text(dept)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDept = value;
                            });
                          },
                          validator: (value) =>
                          value == null ? 'Select a department' : null,
                        ),
                        const SizedBox(height: 50),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue
                            ),
                            onPressed: _createUser,
                            child: const Text('Create User', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(padding: EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back)),
                  SizedBox(width: 5,),
                  Text("Admin Panel - Create User",style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
