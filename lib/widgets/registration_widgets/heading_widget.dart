import 'package:flutter/material.dart';

class BuildHeading extends StatelessWidget {
  final String text;

  const BuildHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}

class BuildSectionTitle extends StatelessWidget {
  final String text;

  const BuildSectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
