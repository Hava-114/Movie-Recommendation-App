import 'package:flutter/material.dart';
import '../widgets/mainscaff.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            /// Title (UNCHANGED as requested)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.settings, size: 30),
                SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),

            const SizedBox(height: 30),

            _settingsButton(context, 'Profile', Icons.person, '/profile'),
            _settingsButton(context, 'Theme', Icons.color_lens, '/theme'),
            _settingsButton(context, 'App Notifications', Icons.notifications, '/notifications'),
            _settingsButton(context, 'Favourites', Icons.favorite, '/favourites'),
            _settingsButton(context, 'Language', Icons.language, '/language'),
            _settingsButton(context, 'Help', Icons.help_outline, '/help'),
            _settingsButton(context, 'About', Icons.info_outline, '/about'),

            const SizedBox(height: 20),

            /// Highlighted: Add Account
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 65,
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/addAccount'),
                child: const Text(
                  'Add Account',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Logout in RED
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged out Successfully!')),
        );
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    ));
  }

  /// Reusable button builder
  Widget _settingsButton(BuildContext context, String title, IconData icon, String route) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:  Colors.purple.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: ListTile(
            leading: Icon(icon, color: Colors.white),
            
            title: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          
        ),
      ),
    );
  }
}
