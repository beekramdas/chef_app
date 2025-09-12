import 'package:flutter/material.dart';

class IngredientsTile extends StatefulWidget {
  final String ingredientsPath;
  final String ingredientsName;
  final bool selectedIngredients;

  IngredientsTile({
    super.key,
    required this.ingredientsPath,
    required this.ingredientsName,
    required this.selectedIngredients,
  });

  @override
  State<IngredientsTile> createState() => _IngredientsTileState();
}

class _IngredientsTileState extends State<IngredientsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: !widget.selectedIngredients
                  ? Color(0XFBE8EAED)
                  : Colors.transparent,
            ),
            color: widget.selectedIngredients
                ? Color(0XFBFFEBE4)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            widget.ingredientsPath,
            color: widget.selectedIngredients
                ? Color(0XFBFB6D3A)
                : Color(0XFB32343E),
            fit: BoxFit.none,
          ),
        ),
        Text(widget.ingredientsName),
      ],
    );
    ;
  }
}
