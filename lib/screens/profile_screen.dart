import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userEmail = authProvider.userEmail ?? 'Not logged in';
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'User Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                // userEmail,
                'Logged in with: $userEmail',
                style: TextStyle(
                  fontSize: 16, 
                  //  color: 
                  color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : theme.primaryColor,
                 
                   ),
              ),
            ),
            Divider(height: 40),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(userEmail),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Account Type'),
              subtitle: Text('Standard User'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              subtitle: Text('Manage your preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
