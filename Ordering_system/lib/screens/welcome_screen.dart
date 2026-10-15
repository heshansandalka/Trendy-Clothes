import 'package:flutter/material.dart';
import '../providers/shop_provider.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final ShopProvider provider;

  const WelcomeScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full Screen Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=1000&auto=format&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) =>
                  Container(color: const Color(0xFF1A252F)),
            ),
          ),

          // 2. Dark Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(100),
                    Colors.black.withAlpha(180),
                    Colors.black.withAlpha(240),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 3. Main Center Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),

                  // App Logo & Emblem
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 2),
                    ),
                    child: const Icon(
                      Icons.checkroom_rounded,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // App Title
                  const Text(
                    'TRENDY CLOTHES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // App Description Box (Frosted Glass Card)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Text(
                      'Discover the latest fashion trends, premium quality outfits, jackets, and shoes. Seamlessly order your favorite clothes with real-time delivery tracking.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // 4. Single Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.login_rounded, size: 22),
                      label: const Text(
                        'SIGN IN TO YOUR ACCOUNT',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => LoginScreen(provider: provider),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Guest Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white54,
                          width: 1.5,
                        ),
                        backgroundColor: Colors.black.withAlpha(80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                      label: const Text(
                        'CONTINUE AS GUEST',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {
                        provider.loginAsCustomer();
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Powered by Flutter Clothing System',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withAlpha(150),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
