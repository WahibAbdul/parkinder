import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/features/history/ui/history_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Icon(
          Icons.car_repair_outlined,
          size: 40,
        ),
        Spacing.hMedium,
        Text(
          'Parkinder',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ),
            );
          },
          icon: Icon(
            Icons.history,
            color: theme.primaryColor,
            size: 30,
          ),
        )
      ],
    );
  }
}
