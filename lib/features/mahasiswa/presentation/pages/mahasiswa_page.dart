import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/core/widgets/common_widget.dart';
import 'package:first_proj/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:first_proj/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';
import 'package:first_proj/features/mahasiswa/presentation/widgets/mahasiswa_comment_widget.dart';
import 'package:first_proj/features/mahasiswa/data/repositories/mahasiswa_comment_repository.dart';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({super.key});

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  int selectedTab = 0; // 0: Mahasiswa, 1: Comment
  List<dynamic> comments = [];
  String responseTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa & Komentar'),
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
                  child: const Text('Mahasiswa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 0 ? Colors.blue : Colors.grey[300],
                    foregroundColor: selectedTab == 0 ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTab = 1),
                  child: const Text('Comment'),
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
                    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
                    return mahasiswaState.when(
                      loading: () => const LoadingWidget(),
                      error: (error, stack) => CustomErrorWidget(
                        message: 'Gagal memuat data mahasiswa: ${error.toString()}',
                        onRetry: () {
                          ref.read(mahasiswaNotifierProvider.notifier).refresh();
                        },
                      ),
                      data: (mahasiswaList) => MahasiswaListView(
                        mahasiswaList: mahasiswaList,
                        onRefresh: () {
                          ref.invalidate(mahasiswaNotifierProvider);
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
                                final repo = MahasiswaCommentRepository();
                                final data = await repo.getCommentsHttp();
                                stopwatch.stop();
                                setState(() {
                                  comments = data;
                                  responseTime = 'HTTP: ${stopwatch.elapsedMilliseconds} ms';
                                });
                              },
                              child: const Text('Load HTTP'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () async {
                                final stopwatch = Stopwatch()..start();
                                final repo = MahasiswaCommentRepository();
                                final data = await repo.getCommentsDio();
                                stopwatch.stop();
                                setState(() {
                                  comments = data;
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
                          child: comments.isEmpty
                              ? const Center(child: Text('Belum ada data komentar'))
                              : ListView.builder(
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    final comment = comments[index];
                                    return MahasiswaCommentCard(comment: comment);
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
