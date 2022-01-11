import 'dart:math';

import 'package:flutter/material.dart';
import 'package:handling_network_connectivity/ui/shared/snackbars/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.getCharacters(),
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: viewModel.status ? Colors.green : Colors.red,
                centerTitle: true,
                title: const Text(
                  'Characters List',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  Text(
                    viewModel.status ? "Online" : "Offline",
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
              //Checks if the device is actively connected to the internet
              // Pulled from [status] in the viewModel
              body: viewModel.status == false
                  ? const Center(
                      child: Text(
                        'No Internet Connection',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        viewModel.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                viewModel.detail!.image!.url!,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.detail!.name!,
                                              style: AppTextStyles
                                                  .sectionHeadTextStyle,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              viewModel
                                                  .detail!.biography!.fullName!,
                                              style: AppTextStyles
                                                  .characteristicTextStyle
                                                  .copyWith(fontSize: 20),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              ' Born in ${viewModel.detail!.biography!.placeOfBirth!}',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    const Text(
                                      'Biography',
                                      style: AppTextStyles.sectionHeadTextStyle,
                                    ),
                                    Text(
                                      'Alignment: ${viewModel.detail!.biography!.alignment}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'AlterEgos: ${viewModel.detail!.biography!.alterEgos!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'First Apperance: ${viewModel.detail!.biography!.firstAppearance!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Publisher: ${viewModel.detail!.biography!.publisher!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    const SizedBox(height: 32),
                                    const Text(
                                      'Powerstats',
                                      style: AppTextStyles.sectionHeadTextStyle,
                                    ),
                                    Text(
                                      'Combat: ${viewModel.detail!.powerstats!.combat!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Durability: ${viewModel.detail!.powerstats!.durability!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Intelligence: ${viewModel.detail!.powerstats!.intelligence!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Power: ${viewModel.detail!.powerstats!.power!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Speed: ${viewModel.detail!.powerstats!.speed!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                    Text(
                                      'Strength: ${viewModel.detail!.powerstats!.strength!}',
                                      style:
                                          AppTextStyles.characteristicTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    )),
        );
      },
    );
  }
}
