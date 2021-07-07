import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String name, instructor, imagePath;
  final Color color;
  CourseCard(this.name, this.instructor, this.color, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CoursePage(name, instructor, imagePath, color)));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              color: color,
              child: ListTile(
                selectedTileColor: Colors.white30,
                title: Padding(
                  padding: EdgeInsets.fromLTRB(0, 18, 18, 50),
                  child: Text(
                    name,
                    textScaleFactor: 1.8,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                ),
                subtitle: Text(
                  "Instructed by $instructor",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Positioned(
              right: 5,
              height: 150,
              width: 150,
              child: ClipRect(
                child: Container(
                  child: imagePath.isNotEmpty
                      ? Image.asset(imagePath)
                      : Image.asset("images/empty-profile-pic.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
