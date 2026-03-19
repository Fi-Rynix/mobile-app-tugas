import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/core/widgets/common_widget.dart';
import 'package:first_proj/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:first_proj/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';
import 'package:first_proj/features/mahasiswa_aktif/presentation/widgets/post_widget.dart';
import 'package:first_proj/features/mahasiswa_aktif/data/repositories/post_repository.dart';

class MahasiswaAktifPage extends StatefulWidget {
  const MahasiswaAktifPage({super.key});

  @override
  State<MahasiswaAktifPage> createState() => _MahasiswaAktifPageState();
}

class _MahasiswaAktifPageState extends State<MahasiswaAktifPage> {
  int selectedTab = 0; // 0: Mahasiswa Aktif, 1: Posts
  List<dynamic> posts = [];
  String responseTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif & Posts'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedTab = 0),
                  child: const Text('Mahasiswa Aktif'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 0 ? Colors.blue : Colors.grey[300],
                    foregroundColor: selectedTab == 0 ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTab = 1),
                  child: const Text('Posts'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 1 ? Colors.blue : Colors.grey[300],
                    foregroundColor: selectedTab == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedTab == 0
                ? Consumer(builder: (context, ref, _) {
                    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);
                    return mahasiswaAktifState.when(
                      loading: () => const LoadingWidget(),
                      error: (error, stack) => CustomErrorWidget(
                        message: 'Gagal memuat data mahasiswa aktif: ${error.toString()}',
                        onRetry: () {
                          ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
                        },
                      ),
                      data: (mahasiswaAktifList) => MahasiswaAktifListView(
                        mahasiswaAktifList: mahasiswaAktifList,
                        onRefresh: () {
                          ref.invalidate(mahasiswaAktifNotifierProvider);
                        },
                        useModernCard: true,
                      ),
                    );
                  })
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final stopwatch = Stopwatch()..start();
                                final repo = PostRepository();
                                final data = await repo.getPostsHttp();
                                stopwatch.stop();
                                setState(() {
                                  posts = data;
                                  responseTime = 'HTTP: ${stopwatch.elapsedMilliseconds} ms';
                                });
                              },
                              child: const Text('Load HTTP'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final stopwatch = Stopwatch()..start();
                                final repo = PostRepository();
                                final data = await repo.getPostsDio();
                                stopwatch.stop();
                                setState(() {
                                  posts = data;
                                  responseTime = 'Dio: ${stopwatch.elapsedMilliseconds} ms';
                                });
                              },
                              child: const Text('Load Dio'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(responseTime, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: posts.isEmpty
                              ? const Center(child: Text('Belum ada data posts'))
                              : ListView.builder(
                                  itemCount: posts.length,
                                  itemBuilder: (context, index) {
                                    final post = posts[index];
                                    return PostCard(post: post);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
