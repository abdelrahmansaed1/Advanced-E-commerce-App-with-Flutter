import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/one.jpg",
      "assets/images/two.jpg",
      "assets/images/three.jpg",
      "assets/images/four.jpg",
    ];

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 4,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(bottom: 20),
                      //   height:
                      //       MediaQuery.of(context).size.height -
                      //       (kToolbarHeight + AppSizes.kMainBottomNavBarHeigth + 30),
                      //   width: double.infinity,
                      //   child: Image.asset(images[index], fit: BoxFit.fill),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height:
                            MediaQuery.of(context).size.height -
                            (kToolbarHeight +
                                AppSizes.kMainBottomNavBarHeigth +
                                30),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Color(0xffECF3FA)),
                      ),
                      Positioned(
                        bottom: 150,
                        left: 20,
                        child: Text(
                          "Black Friday sale! \nSave up to 25%",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: AppColors.primaryColor,
                              ),
                              top: BorderSide(
                                width: 1,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          child: Text(
                            "Shop now".toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
