import '../models/dashboard_model.dart';

class DashboardRepository {
  //get data dashboard
  Future<DashboardData> getDashboardData() async {
    //network delay
    await Future.delayed(const Duration(seconds: 1));

    //dummy
    return DashboardData(
      userName: 'Admin D4-TI',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '69',
          subtitle: 'Total Mahasiswa',
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '67',
          subtitle: 'Sedang kuliah',
        ),
        DashboardStats(
          title: 'Dosen',
          value: '67',
          subtitle: 'Jumlah dosen',
        ),
        DashboardStats(
          title: 'Lihat Profil',
          value: 'Profil',
          subtitle: 'Lihat profil',
        ),
      ],
    );
  }

  //refresh dashboard data
  Future<DashboardData> refreshDashBoardData() async {
    return getDashboardData();
  }

  //get specific stat by title
  Future<DashboardStats?> getStatByTitle(String title) async {
    final data = await getDashboardData();
    try {
      return data.stats.firstWhere((stat) => stat.title == title);
    } catch (e) {
      return null;
    }
  }
}
