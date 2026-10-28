import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/dummy/dummy_data.dart';
import '../../widgets/attendance_chart.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/profile_header.dart'; // Import header reusable
import '../attendance/history_page.dart';
import '../attendance/scan_presence_page.dart';
import '../message/message_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _DashboardContent(),
    HistoryPage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background utama abu-abu muda
      backgroundColor: const Color(0xFFF5F7FA),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        onScanTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ScanPresencePage()),
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Header Profil Reusable (Putih melengkung bawah)
        const ProfileHeader(),

        // 2. Konten Bawah (Grafik & Info)
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kartu Grafik Kehadiran
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grafik Presentase Kehadiran',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      AttendanceChart(data: DummyData.chartData),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Kartu Info Semester & Tahun Ajaran
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        label: 'Semester',
                        value: 'Ganjil',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        label: 'Tahun Ajaran',
                        value: '2026/2027',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const _InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
