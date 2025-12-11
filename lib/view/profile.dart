import 'package:flutter/material.dart';
import '../widgets/mainscaff.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  final String username = "Bhava";

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Stack(
        children: [
          // ---------------- PURPLE TOP BAR ----------------
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            color: Colors.purple.withOpacity(0.45),
          ),

          // ---------------- PROFILE IMAGE ----------------
          Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            left: 0,
            right: 0,
            child: Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/user.png"),
              ),
            ),
          ),

          // ---------------- USERNAME (Centered) ----------------
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // ---------------- DRAGGABLE BOTTOM SHEET ----------------
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1.0,
            builder: (context, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    Expanded(
                      child: ListView(
                        controller: controller,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildItem(Icons.lock, "Privacy"),
                          _buildItem(Icons.info, "About"),
                          _buildItem(Icons.poll, "Survey"),
                          _buildItem(Icons.settings, "Settings"),
                        ],
                      ),
                    ),
                  
                    Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.6),
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

                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------- SIMPLE ITEM ROW ----------
  Widget _buildItem(IconData icon, String text) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white70),
          title: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white70),
          onTap: () {},
        ),
        Divider(color: Colors.white12, thickness: 0.5),
      ],
    );
  }
}
