import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            // Profile Header with Image Upload
            _buildProfileHeader(context),

            SizedBox(height: 20),

            // User Information
            _buildUserInformation(appState),

            SizedBox(height: 20),

            // Dark Mode Toggle
            _buildDarkModeSwitch(appState),

            SizedBox(height: 20),

            // Blood Type Selector
            _buildBloodTypeSelector(context, appState),

            SizedBox(height: 20),

            // Update Profile Button
            _buildUpdateProfileButton(context),

            SizedBox(height: 20),

            // Donation History
            _buildDonationHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/profile.jpg'), // Default image
              backgroundColor: Colors.grey[300],
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  // Here, you would typically use a package like 'image_picker' to select an image
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Uploading image (simulated)')));
                  // Simulating image upload, replace with actual functionality
                  await Future.delayed(Duration(seconds: 2));
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image uploaded successfully!')));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 18,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text('Mordheesh',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('Blood Donor', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildUserInformation(AppState appState) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.person, color: Colors.red),
        title: Text('Blood Type: ${appState.bloodType}'),
        subtitle: Text('Donor since: Jan 2020'),
      ),
    );
  }

  Widget _buildDarkModeSwitch(AppState appState) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text('Dark Mode'),
        trailing: Switch(
          value: appState.isDarkMode,
          onChanged: (value) => appState.toggleDarkMode(),
          activeColor: Colors.red,
        ),
      ),
    );
  }

  Widget _buildBloodTypeSelector(BuildContext context, AppState appState) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: DropdownButtonFormField<String>(
          value: appState.bloodType,
          onChanged: (String? newValue) {
            if (newValue != null) {
              appState.updateBloodType(newValue);
            }
          },
          items: <String>['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Update Blood Type',
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateProfileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Updated')));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text('Update Profile', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildDonationHistory(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.history, color: Colors.red),
        title: Text('Donation History'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Viewing Donation History')));
        },
      ),
    );
  }
}
