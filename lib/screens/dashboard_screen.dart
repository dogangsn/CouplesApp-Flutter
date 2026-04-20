import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  int _calculateDaysTogether(DateTime? startDate) {
    if (startDate == null) return 0;
    final now = DateTime.now();
    final difference = now.difference(startDate);
    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final daysTogether = _calculateDaysTogether(authService.relationshipStartDate);

        Widget _buildDashCard(String title, IconData icon, Color accent, VoidCallback? onTap) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                     padding: const EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: accent.withOpacity(0.15),
                       shape: BoxShape.circle,
                     ),
                     child: Icon(icon, color: accent, size: 28),
                   ),
                   const SizedBox(height: 15),
                   Text(title, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                ],
              )
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("CouplesApp", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(icon: const Icon(Icons.settings), onPressed: (){})
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // 99 GUNLER CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))
                    ]
                  ),
                  child: Column(
                    children: [
                       Text(
                         daysTogether.toString(),
                         style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: AppColors.primary, height: 1.0),
                       ),
                       const Text("Günler", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                       const SizedBox(height: 8),
                       const Text("Birlikteliğinizden beri", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // GRID CARDS
                Row(
                  children: [
                    Expanded(child: _buildDashCard("Konum", Icons.map, const Color(0xFFb395ff), () => context.go('/map'))),
                    const SizedBox(width: 15),
                    Expanded(child: _buildDashCard("Galeri", Icons.photo_album, const Color(0xFFf9d689), () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Galeri yakında!"))))),
                  ]
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: _buildDashCard("Görevler", Icons.check_circle, const Color(0xFF4cd137), () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Görevler yakında!"))))),
                    const SizedBox(width: 15),
                    Expanded(child: _buildDashCard("Hayvanım", Icons.pets, const Color(0xFFFF4B72), () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Hayvanım yakında!"))))),
                  ]
                )
              ],
            ),
          ),
        );
      },
    );
  }
}