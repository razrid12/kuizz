import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      home: LoginPage(),
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(username: 'user'), // Placeholder username
      },
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Local Image (Placeholder for register image)
              Image.asset('images/login.webp',width:2000, height: 100),
              SizedBox(height: 20),
              
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username cannot be empty";
                  }
                  return null;
                },
              ),
              
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
              ),
              
              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Confirm Password"),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              
              // Register Button
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register Successful')));
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Local Image (Placeholder for login image)
            Image.asset('images/login.webp', width: 2000 , height: 100),
            SizedBox(height: 20),
            
            // Username Field
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            
            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            
            // Login Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_usernameController.text == 'user' && _passwordController.text == 'password') {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
                }
              },
              child: Text("Login"),
            ),
            
            // Register Redirect
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Text("Belum punya akun? Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hallo $username, mau makan apa?'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Local Image (Placeholder for home image)
          Image.asset('images/banner.webp', width:1000 , height: 500),
          SizedBox(height: 20),
          
          // List of Food Items
          _buildFoodItem(
            imageUrl: 'images/menu.webp',
            foodName: 'Nasi Goreng',
            price: 'Rp 20,000',
            context: context,
          ),
          _buildFoodItem(
            imageUrl: 'images/menu.webp',
            foodName: 'Mie Goreng',
            price: 'Rp 15,000',
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem({
    required String imageUrl,
    required String foodName,
    required String price,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Image.asset(imageUrl, width: 50, height: 50),
      title: Text(foodName),
      subtitle: Text(price),
      trailing: ElevatedButton(
        onPressed: () {
          // Navigate to detail order (this can be expanded in the future)
        },
        child: Text('Beli'),
      ),
    );
  }
}
