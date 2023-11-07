import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doa_test_app/ui/my_app_state.dart';

class FilterButton extends StatelessWidget{
  final IconData buttonIcon;
  final String buttonString;
  final bool buttonCondition;

  FilterButton({required this.buttonIcon, required this.buttonString,required this.buttonCondition});

  @override
  Widget build(BuildContext context){

    var appState = context.watch<MyAppState>();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          appState.toggleFilter(buttonString);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              buttonIcon,
              //TODO review if null protection relieble
              color: appState.filters[buttonString]! ? Colors.black : Colors.grey,
            ),
            if (buttonCondition)
              Text(buttonString),
          ],
        ),
      ),
    );
  }
}