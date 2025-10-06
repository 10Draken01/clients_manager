import 'package:clients_manager/features/clients_display/presentation/widgets/molecules/skeleton_client_card.dart';
import 'package:flutter/material.dart';

class LoadingClientsSkeleton extends StatelessWidget {
  final int itemCount;

  const LoadingClientsSkeleton({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const SkeletonClientCard();
      },
    );
  }
}