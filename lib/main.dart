import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expenses.dart';

final kcolorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // appBarTheme: AppBarTheme().copyWith(
        //   backgroundColor: kDarkColorScheme.onPrimaryContainer,
        //   foregroundColor: kDarkColorScheme.primaryContainer,
        // ),
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kcolorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kcolorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kcolorScheme.onPrimaryContainer,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
}
