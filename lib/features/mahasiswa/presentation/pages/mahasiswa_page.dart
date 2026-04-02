import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_proj/core/widgets/common_widget.dart';
import 'package:first_proj/features/mahasiswa/data/models/comment_model.dart';
import 'package:first_proj/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:first_proj/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';
import 'package:first_proj/features/mahasiswa/presentation/widgets/comment_widget.dart';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({super.key});

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  int selectedTab = 0; // 0: Mahasiswa, 1: Comment

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa & Komentar'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tab buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedTab = 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 0 ? Colors.blue : Colors.grey[300],
                    foregroundColor: selectedTab == 0 ? Colors.white : Colors.black,
                  ),
                  child: const Text('Mahasiswa'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTab = 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTab == 1 ? Colors.blue : Colors.grey[300],
                    foregroundColor: selectedTab == 1 ? Colors.white : Colors.black,
                  ),
                  child: const Text('Comment'),
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: selectedTab == 0
                ? _MahasiswaTab()
                : _CommentTab(),
          ),
        ],
      ),
    );
  }
}

// mahasiswa
class _MahasiswaTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}

// comment
class _CommentTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentState = ref.watch(mahasiswaCommentNotifierProvider);
    final savedComments = ref.watch(savedCommentsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section: Saved Comments
        _SavedCommentSection(savedComments: savedComments, ref: ref),

        // Section Title: Daftar Komentar
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Text(
            'Daftar Komentar',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),

        // Section: Comment List
        Expanded(
          child: commentState.when(
            loading: () => const LoadingWidget(),
            error: (error, stack) => CustomErrorWidget(
              message: 'Gagal memuat komentar: ${error.toString()}',
              onRetry: () {
                ref.read(mahasiswaCommentNotifierProvider.notifier).refresh();
              },
            ),
            data: (commentList) => _CommentListWithSave(
              commentList: commentList,
              onRefresh: () {
                ref.invalidate(mahasiswaCommentNotifierProvider);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// =====================
// SECTION: SAVED COMMENTS
// =====================
class _SavedCommentSection extends StatefulWidget {
  final AsyncValue<List<Map<String, String>>> savedComments;
  final WidgetRef ref;

  const _SavedCommentSection({
    required this.savedComments,
    required this.ref,
  });

  @override
  State<_SavedCommentSection> createState() => _SavedCommentSectionState();
}

class _SavedCommentSectionState extends State<_SavedCommentSection> {
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
                'Komentar Tersimpan',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),

              widget.savedComments.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (comments) {
                  if (comments.isEmpty) return const SizedBox.shrink();

                  return TextButton.icon(
                    onPressed: () async {
                      await widget.ref
                          .read(mahasiswaCommentNotifierProvider.notifier)
                          .clearSavedComments();

                      widget.ref.invalidate(savedCommentsProvider);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Semua komentar tersimpan dihapus'),
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
          widget.savedComments.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => Text(
              'Gagal membaca komentar tersimpan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            data: (comments) {
              if (comments.isEmpty) {
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
                        'Belum ada komentar. Tekan ikon simpan untuk menyimpan.',
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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.blue.shade100,
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemBuilder: (context, index) {
                    final comment = comments[index];

                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        '${comment['username'] ?? '-'}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      subtitle: Text(
                        'ID: ${comment['user_id'] ?? '-'} · ${_formatDate(comment['saved_at'] ?? '')}',
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
                              .read(mahasiswaCommentNotifierProvider.notifier)
                              .removeSavedComment(comment['user_id'] ?? '');

                          widget.ref.invalidate(savedCommentsProvider);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '\'${comment['username'] ?? '-'}\' dihapus dari tersimpan',
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
// SECTION: COMMENT LIST WITH SAVE
// =====================
class _CommentListWithSave extends ConsumerWidget {
  final List<MahasiswaCommentModel> commentList;
  final VoidCallback onRefresh;

  const _CommentListWithSave({
    required this.commentList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: commentList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final comment = commentList[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${comment.id}', style: const TextStyle(fontSize: 10)),
              ),
              title: Text(
                comment.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                comment.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan komentar ini',
                onPressed: () async {
                  await ref
                      .read(mahasiswaCommentNotifierProvider.notifier)
                      .saveSelectedComment(comment);

                  ref.invalidate(savedCommentsProvider);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '\'${comment.name}\' berhasil disimpan',
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
// UTILITY FUNCTION
// =====================
String _formatDate(String isoString) {
  if (isoString.isEmpty) return '-';
  try {
    final date = DateTime.parse(isoString);
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  } catch (e) {
    return isoString;
  }
}
