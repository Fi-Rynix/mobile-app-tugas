import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/core/widgets/common_widget.dart';
import 'package:first_proj/features/dosen/data/models/dosen_model.dart';
import 'package:first_proj/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:first_proj/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedDosen = ref.watch(savedDosenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedUserSection(savedDosen: savedDosen, ref: ref),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Dosen',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: dosenState.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: 'Gagal memuat data dosen: ${error.toString()}',
                onRetry: () {
                  ref.read(dosenNotifierProvider.notifier).refresh();
                },
              ),
              data: (dosenList) => _DosenListWithSave(
                dosenList: dosenList,
                onRefresh: () {
                  ref.invalidate(dosenNotifierProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// save user section
class _SavedUserSection extends StatefulWidget {
  final AsyncValue<List<Map<String, String>>> savedDosen;
  final WidgetRef ref;

  const _SavedUserSection({
    required this.savedDosen,
    required this.ref,
  });

  @override
  State<_SavedUserSection> createState() => _SavedUserSectionState();
}

class _SavedUserSectionState extends State<_SavedUserSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),

              widget.savedDosen.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (dosen) {
                  if (dosen.isEmpty) return const SizedBox.shrink();

                  return TextButton.icon(
                    onPressed: () async {
                      await widget.ref
                          .read(dosenNotifierProvider.notifier)
                          .clearSavedDosen();

                      widget.ref.invalidate(savedDosenProvider);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Semua data tersimpan dihapus'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete_sweep_outlined, size: 14),
                    label: const Text('Hapus Semua'),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // CONTENT
          widget.savedDosen.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => Text(
              'Gagal membaca data tersimpan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            data: (dosen) {
              if (dosen.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Belum ada data. Tekan ikon simpan untuk menyimpan.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dosen.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.green.shade100,
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemBuilder: (context, index) {
                    final user = dosen[index];

                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.green.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        '${user['username'] ?? '-'}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      subtitle: Text(
                        'ID: ${user['user_id'] ?? '-'} · ${_formatDate(user['saved_at'] ?? '')}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        color: Colors.red,
                        onPressed: () async {
                          await widget.ref
                              .read(dosenNotifierProvider.notifier)
                              .removeSavedDosen(user['user_id'] ?? '');

                          widget.ref.invalidate(savedDosenProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '\'${user['username'] ?? '-'}\' dihapus dari local storage',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================
// LIST DOSEN
// =====================
class _DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;

  const _DosenListWithSave({
    required this.dosenList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: dosenList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final dosen = dosenList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${dosen.id}'),
              ),
              title: Text(dosen.name),
              subtitle: Text(
                '${dosen.username} · ${dosen.email}\n${dosen.address.city}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan dosen ini',
                onPressed: () async {
                  await ref
                      .read(dosenNotifierProvider.notifier)
                      .saveSelectedDosen(dosen);

                  ref.invalidate(savedDosenProvider);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '\'${dosen.username}\' berhasil disimpan ke local storage',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// =====================
// FORMAT DATE
// =====================
String _formatDate(String isoString) {
  if (isoString.isEmpty) return '-';

  try {
    final date = DateTime.parse(isoString);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  } catch (e) {
    return isoString;
  }
}