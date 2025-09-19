import 'package:flutter/material.dart';

class NotificationTile extends StatefulWidget {
  final String customerName, activity, activityTime;

  NotificationTile({
    super.key,
    required this.customerName,
    required this.activity,
    required this.activityTime,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Column(
        spacing: 13,
        children: [
          Row(
            spacing: 15,
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0XFB98A8B8),
                ),
              ),
              Container(
                width: 144,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.customerName,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0XFB32343E),
                            ),
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                            text: widget.activity,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0XFB9C9BA6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.activityTime,
                      style: TextStyle(fontSize: 10, color: Color(0XFB9C9BA6)),
                    ),
                  ],
                ),
                //Text(
                //widget.activity,
                //style: TextStyle(color: Color(0XFB9C9BA6), fontSize: 13),
              ),

              Spacer(),
              Container(
                height: 54,
                width: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0XFB98A8B8),
                ),
              ),
            ],
          ),
          Divider(color: Color(0XFBF0F4F9)),
        ],
      ),
    );
  }
}
