import 'package:flutter/material.dart';
import 'login_page.dart';
import 'donor_form.dart';
import 'acceptor_search.dart';

void main() {
  runApp(const BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _titleController;
  late Animation<double> _titleAnimation;
  bool _isHoveringRed = false;
  bool _isHoveringGreen = false;

  @override
  void initState() {
    super.initState();
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeInOut),
    );
    _titleController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00c9ff), Color(0xFF92fe9d)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            // Blood Symbol
            const Icon(
              Icons.bloodtype,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            
            // Animated Title with Hover Effect
            MouseRegion(
              onEnter: (_) => _titleController.forward(),
              onExit: (_) => _titleController.reverse(),
              child: AnimatedBuilder(
                animation: _titleAnimation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outline text
                      Text(
                        "BLOOD DONATION",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      // Fill text with animation and border
                      Stack(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: _titleAnimation.value,
                              child: Text(
                                "BLOOD DONATION",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                  color: const Color(0xFF37FF8B),
                                  shadows: [
                                    Shadow(
                                      color: const Color(0xFF37FF8B).withValues(alpha: 0.8),
                                      blurRadius: 23,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Right border effect
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: _titleAnimation.value > 0.1 ? 6 : 0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF37FF8B),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF37FF8B),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            
            const SizedBox(height: 8),
            const Text(
              "Save Lives by Donating Blood",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            
            const SizedBox(height: 60),
            
            // Action Buttons
            Column(
              children: [
                // Become a Donor Button
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringRed = true),
                  onExit: (_) => setState(() => _isHoveringRed = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    transform: Matrix4.identity()
                      ..scale(_isHoveringRed ? 1.1 : 1.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DonorForm()),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFFf43f5e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Become a Donor",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Register as Blood Donor",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Find Donors Button
                MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringGreen = true),
                  onExit: (_) => setState(() => _isHoveringGreen = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    transform: Matrix4.identity()
                      ..scale(_isHoveringGreen ? 1.1 : 1.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AcceptorSearch()),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22c55e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Find Donors",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Search Blood Donors",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}