import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // App Title
            Text('Blood App Dashboard',
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 20),

            // Overview Card
            _buildOverviewCard(context),

            SizedBox(height: 16),

            // Blood Type Availability
            _buildCard(
              context,
              title: 'Blood Type Availability',
              subtitle: 'Current Inventory Status',
              icon: Icons.bloodtype,
              color: Colors.red,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Viewing blood type stats')));
              },
            ),

            SizedBox(height: 16),

            // Donation Centers
            _buildCard(
              context,
              title: 'Donation Centers',
              subtitle: 'Nearest Locations',
              icon: Icons.local_hospital,
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Viewing donation centers')));
              },
            ),

            SizedBox(height: 16),

            // Upcoming Events
            _buildCard(
              context,
              title: 'Upcoming Events',
              subtitle: 'Blood Donation Drives',
              icon: Icons.calendar_today,
              color: Colors.green,
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Viewing events')));
              },
            ),

            SizedBox(height: 16),

            // Statistics
            _buildCard(
              context,
              title: 'Donation Statistics',
              subtitle: 'Overview of Donations',
              icon: Icons.show_chart,
              color: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Viewing stats')));
              },
            ),

            SizedBox(height: 16),

            // User's Donation History
            _buildCard(
              context,
              title: 'Your Donation History',
              subtitle: 'Your Impact',
              icon: Icons.person,
              color: Colors.orange,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Viewing your history')));
              },
            ),

            SizedBox(height: 16),

            // Quick Actions
            _buildQuickActionsCard(context),

            SizedBox(height: 16),

            // Emergency Alerts
            _buildEmergencyAlert(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Here\'s an overview of today\'s blood needs:'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('O- Units: 15'),
                Text('A- Units: 10'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Notifications'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notifications tapped!')));
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Icon(Icons.contact_page, color: Colors.blue),
            title: Text('Contact Support'),
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Support contacted!')));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyAlert(BuildContext context) {
    return Card(
      color: Colors.red[100],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.warning, color: Colors.red),
        title: Text('Emergency Alert',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        subtitle: Text('Urgent need for O- blood!',
            style: TextStyle(color: Colors.red)),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Emergency Alert acknowledged')));
        },
      ),
    );
  }
}