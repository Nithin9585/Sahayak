import 'package:flutter/material.dart';

class OfflineManagerScreen extends StatefulWidget {
  const OfflineManagerScreen({super.key});

  @override
  State<OfflineManagerScreen> createState() => _OfflineManagerScreenState();
}

class _OfflineManagerScreenState extends State<OfflineManagerScreen> {
  // Mock Downloaded Data
  final List<Map<String, dynamic>> _downloads = [
    {'title': 'Nali Kali: Math Module 1', 'size': '45 MB', 'type': 'Video Pack'},
    {'title': 'TaRL Reading Assets', 'size': '12 MB', 'type': 'Images'},
    {'title': 'Classroom Management Guide', 'size': '5 MB', 'type': 'PDF'},
    {'title': 'Kannada Rhymes Vol. 1', 'size': '28 MB', 'type': 'Audio'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Content Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded),
            onPressed: () {
              setState(() {
                _downloads.clear();
              });
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('All downloads cleared!')),
               );
            },
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: _downloads.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_download_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text('No offline content found.', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _downloads.length,
            itemBuilder: (context, index) {
              final item = _downloads[index];
              return Card(
                elevation: 0,
                color: Colors.grey[50],
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[200]!),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIcon(item['type']),
                      color: Colors.teal,
                    ),
                  ),
                  title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${item['size']} • ${item['type']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                    onPressed: () {
                      setState(() {
                         _downloads.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Item deleted.')),
                       );
                    },
                  ),
                ),
              );
            },
          ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Storage Used', style: TextStyle(color: Colors.grey)),
                Text('90 MB / 2 GB', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            CircularProgressIndicator(
              value: 90 / 2000, 
              color: Colors.teal, 
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'Video Pack': return Icons.video_library_rounded;
      case 'Images': return Icons.image_rounded;
      case 'Audio': return Icons.headphones_rounded;
      case 'PDF': return Icons.picture_as_pdf_rounded;
      default: return Icons.folder_rounded;
    }
  }
}
