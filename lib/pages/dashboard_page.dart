import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                _buildMenuitem(
                  context,
                  'Mahasiswa',
                  provider.mahasiswa,
                  Icons.school,
                  Colors.blue,
                  provider.tambahMahasiswa,
                ),
                const SizedBox(height: 15),
                _buildMenuitem(
                  context,
                  'Dosen',
                  provider.dosen,
                  Icons.person,
                  Colors.green,
                  provider.tambahDosen,
                ),
                const SizedBox(height: 15),
                _buildMenuitem(
                  context,
                  'Mata Kuliah',
                  provider.mataKuliah,
                  Icons.book,
                  Colors.orange,
                  provider.tambahMataKuliah,
                ),
              ],
            ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuitem(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color color,
    Function() onTap,
  ) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, size: 35, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total: $count',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
