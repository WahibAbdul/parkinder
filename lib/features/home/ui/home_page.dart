import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/features/home/ui/widgets/home_body.dart';
import 'package:parkinder/features/home/ui/widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // bottom: false,
        child: Container(
          padding: const EdgeInsets.all(Dimens.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              Spacing.vertical,
              const Expanded(
                child: HomeBody(),
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: Dimens.margin),
              //   child: HomeFooter(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
