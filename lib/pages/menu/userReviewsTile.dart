import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserReviewTile extends StatefulWidget {
  final String reviewTime;
  final String reviewTitle;
  final int userRating;
  final String reviewDesc;
  final int maxRating;

  UserReviewTile({
    super.key,
    required this.reviewTime,
    required this.reviewTitle,
    required this.userRating,
    required this.reviewDesc,
    required this.maxRating,
  });

  @override
  State<UserReviewTile> createState() => _UserReviewTileState();
}

class _UserReviewTileState extends State<UserReviewTile> {
  late DateTime parsedDate;
  late String formattedDate;

  @override
  void initState() {
    parsedDate = DateFormat("dd-MM-yyyy").parse(widget.reviewTime);
    formattedDate = DateFormat("dd/MM/yyyy").format(parsedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: Color(0XFB98A8B8),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Color(0XFBF6F8FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0XFB9C9BA6),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.more_horiz,
                          color: Color(0XFB9C9BA6),
                          size: 22,
                        ),
                      ],
                    ),
                    Text(
                      widget.reviewTitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFB32343E),
                      ),
                    ),
                    Row(
                      children: List.generate(widget.maxRating, (index) {
                        if (index < widget.userRating) {
                          return Icon(
                            Icons.star,
                            color: Color(0XFBFB6D3A),
                            size: 14,
                          );
                        } else {
                          return Icon(
                            Icons.star_border_outlined,
                            color: Color(0XFBFB6D3A),
                            size: 14,
                          );
                        }
                      }),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.reviewDesc,
                      style: TextStyle(fontSize: 12, color: Color(0XFB747783)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
