import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/modules/controller/homeController.dart';
import 'package:newsapp/modules/view/newsDetailsPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String formatDate(String dateStr) {
    if (dateStr.isEmpty) return "Unknown date";
    try {
      DateTime date = DateTime.parse(dateStr).toLocal();
      return DateFormat(
        'dd MMM yyyy, hh:mm a',
      ).format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          "Dashboard",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            if (newsController.newsList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: newsController.newsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(NewsDetailsPage(),
                        arguments: newsController.newsList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 16),
                    margin: EdgeInsets.only(bottom: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                newsController.newsList[index]["urlToImage"] ??
                                    "No Image Found",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 250,
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.broken_image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          newsController.newsList[index]["title"] ?? "",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.lock_clock_outlined,
                                size: 15, color: Colors.black.withOpacity(0.5)),
                            SizedBox(width: 5),
                            Text(
                              formatDate(newsController.newsList[index]
                                      ["publishedAt"] ??
                                  ""),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
