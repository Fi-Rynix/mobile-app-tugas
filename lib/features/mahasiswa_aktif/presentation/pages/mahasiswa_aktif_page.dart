import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/core/widgets/common_widget.dart';
import 'package:first_proj/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:first_proj/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaAktifState.when(
        // State: Loading
        loading: () => const LoadingWidget(),
        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa aktif: ${error.toString()}',
          onRetry: () {
            ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
          },
        ),
        // State: memunggil data mahasiswa aktif dari mahasiswa aktif list dan menanggil widget
        data: (mahasiswaAktifList) {
          return MahasiswaAktifListView(
            mahasiswaAktifList: mahasiswaAktifList,
            onRefresh: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
            useModernCard: true,
          );
        },
      ),
    );
  }
}
