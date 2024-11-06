import 'package:flutter/material.dart';

void main() {
  runApp(const PPTCreatorApp());
}

class PPTCreatorApp extends StatelessWidget {
  const PPTCreatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI PPT Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PPTCreatorHome(),
    );
  }
}

class PPTCreatorHome extends StatefulWidget {
  const PPTCreatorHome({super.key});

  @override
  State<PPTCreatorHome> createState() => _PPTCreatorHomeState();
}

class _PPTCreatorHomeState extends State<PPTCreatorHome> {
  final List<Slide> slides = [];
  int currentSlideIndex = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Başlangıçta boş bir slayt ekle
    slides.add(Slide(title: 'Yeni Slayt', content: ''));
  }

  void addNewSlide() {
    setState(() {
      slides.add(Slide(title: 'Yeni Slayt ${slides.length + 1}', content: ''));
      currentSlideIndex = slides.length - 1;
    });
  }

  void deleteCurrentSlide() {
    if (slides.length > 1) {
      setState(() {
        slides.removeAt(currentSlideIndex);
        if (currentSlideIndex > 0) currentSlideIndex--;
      });
    }
  }

  void updateSlide() {
    setState(() {
      slides[currentSlideIndex] = Slide(
        title: titleController.text,
        content: contentController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI PowerPoint Oluşturucu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Kaydetme işlevi eklenecek
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sunum kaydedildi')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              // Sunum gösterisi başlatma işlevi
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sol Kenar Çubuğu - Slayt Önizlemeleri
          Container(
            width: 200,
            color: Colors.grey[200],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: addNewSlide,
                    icon: const Icon(Icons.add),
                    label: const Text('Yeni Slayt'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: currentSlideIndex == index
                            ? Colors.blue[100]
                            : Colors.white,
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(
                            slides[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            'Slayt ${index + 1}',
                            style: TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            setState(() {
                              currentSlideIndex = index;
                              titleController.text = slides[index].title;
                              contentController.text = slides[index].content;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Ana İçerik Alanı
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Üst Araç Çubuğu
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: deleteCurrentSlide,
                        tooltip: 'Slaytı Sil',
                      ),
                      IconButton(
                        icon: const Icon(Icons.format_bold),
                        onPressed: () {
                          // Kalın yazı formatı
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.format_italic),
                        onPressed: () {
                          // İtalik yazı formatı
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.format_list_bulleted),
                        onPressed: () {
                          // Madde işareti ekleme
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: () {
                          // Resim ekleme
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Slayt Düzenleme Alanı
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                labelText: 'Slayt Başlığı',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => updateSlide(),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: TextField(
                                controller: contentController,
                                decoration: const InputDecoration(
                                  labelText: 'Slayt İçeriği',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: null,
                                onChanged: (value) => updateSlide(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sağ Kenar Çubuğu - AI Asistan
          Container(
            width: 300,
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'AI Asistan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'AI\'ya bir şey sorun...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // AI işlevselliği eklenecek
                  },
                  icon: const Icon(Icons.smart_toy),
                  label: const Text('AI\'dan Yardım İste'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'AI önerileri burada görünecek...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Slide {
  String title;
  String content;
  
  Slide({
    required this.title,
    required this.content,
  });
}
