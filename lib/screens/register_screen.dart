import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String username = ''; 

  final TextEditingController _usernameController = TextEditingController(); 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordLengthValid = false;
  bool _isPasswordUppercaseValid = false;
  bool _isPasswordLowercaseValid = false;
  bool _isPasswordDigitValid = false;
  bool _isPasswordMatch = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateUsername); 
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
    _usernameController.dispose(); 
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateUsername() {
    setState(() {
      username = _usernameController.text;
      _isUsernameValid = username.length >= 3; 
    });
  }

  void _validateEmail() {
    setState(() {
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text);
    });
  }

  void _validatePassword() {
    setState(() {
      password = _passwordController.text;
      _isPasswordLengthValid = password.length >= 6; 
      _isPasswordUppercaseValid = password.contains(RegExp(r'[A-Z]'));
      _isPasswordLowercaseValid = password.contains(RegExp(r'[a-z]'));
      _isPasswordDigitValid = password.contains(RegExp(r'[0-9]'));
      _isPasswordMatch = password == _confirmPasswordController.text;
    });
  }

  void _validateConfirmPassword() {
    setState(() {
      confirmPassword = _confirmPasswordController.text;
      _isPasswordMatch = password == confirmPassword;
    });
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created! (Dummy only)')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.textTheme.headlineSmall?.color,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.headlineLarge?.color,
                ),
              ),
              SizedBox(height: 30),

  
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  suffixIcon: _usernameController.text.isNotEmpty
                      ? (_isUsernameValid
                          ? Icon(Icons.check_circle_outline, color: Colors.green)
                          : Icon(Icons.cancel_outlined, color: Colors.red))
                      : null,
                ),
                onChanged: (val) {
                  username = val;
                  _validateUsername(); 
                },
                validator: (val) => val!.isEmpty ? 'Enter username' : (val.length < 3 ? 'Min 3 characters' : null),
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  suffixIcon: _emailController.text.isNotEmpty
                      ? (_isEmailValid
                          ? Icon(Icons.check_circle_outline, color: Colors.green)
                          : Icon(Icons.cancel_outlined, color: Colors.red))
                      : null,
                ),
                onChanged: (val) {
                  email = val;
                  _validateEmail();
                },
                validator: (val) => val!.isEmpty ? 'Enter email' : null,
              ),
              SizedBox(height: 16),

         
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword, 
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; 
                      });
                    },
                  ),
                ),
                onChanged: (val) {
                  password = val;
                  _validatePassword();
                },
                validator: (val) => val!.length < 6 ? 'Min 6 chars' : null,
              ),
              SizedBox(height: 10),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValidationRow('Minimum 6 characters', _isPasswordLengthValid), 
                  _buildValidationRow('At least 1 uppercase', _isPasswordUppercaseValid),
                  _buildValidationRow('At least 1 lowercase', _isPasswordLowercaseValid),
                  _buildValidationRow('At least 1 number', _isPasswordDigitValid),
                ],
              ),
              SizedBox(height: 16),

           
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword, 
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword; 
                      });
                    },
                  ),
                ),
                onChanged: (val) {
                  confirmPassword = val;
                  _validateConfirmPassword();
                },
                validator: (val) => val != password ? 'Passwords do not match' : null,
              ),
              SizedBox(height: 20),

             
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? newValue) {
                    },
                    activeColor: theme.primaryColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of service',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: theme.textTheme.bodyMedium?.color,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy policy',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                    
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget _buildValidationRow(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: isValid ? Colors.green : Colors.grey,
            size: 18,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
