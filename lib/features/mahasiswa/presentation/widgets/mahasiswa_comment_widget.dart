import 'package:flutter/material.dart';
import 'package:first_proj/features/mahasiswa/data/models/mahasiswa_comment_model.dart';

class MahasiswaCommentCard extends StatelessWidget {
  final MahasiswaCommentModel comment;
  final VoidCallback? onTap;

  const MahasiswaCommentCard({Key? key, required this.comment, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                comment.email,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                comment.body,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MahasiswaCommentListView extends StatelessWidget {
  final List<MahasiswaCommentModel> commentList;
  final VoidCallback? onRefresh;

  const MahasiswaCommentListView({Key? key, required this.commentList, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (commentList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.comment, size: 64, color: Colors.grey),
            const SizedBox(height: 24),
            const Text('Tidak ada komentar', style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('Belum ada komentar yang tersedia', style: TextStyle(fontSize: 14, color: Colors.grey)),
            if (onRefresh != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: commentList.length,
        itemBuilder: (context, index) {
          final comment = commentList[index];
          return MahasiswaCommentCard(comment: comment);
        },
      ),
    );
  }
}
