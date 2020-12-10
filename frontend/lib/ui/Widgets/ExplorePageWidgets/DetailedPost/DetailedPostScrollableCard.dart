import 'package:flutter/material.dart';
import 'package:size_hub/data/UserMeasurementsData.dart';
import 'package:size_hub/ui/Widgets/Common/ScrollableCard.dart';
import 'package:size_hub/ui/Widgets/ExplorePageWidgets/DetailedPost/DetailedPostScrollableCardContent.dart';

class DetailedPostScrollableCard extends StatelessWidget {
  final UserMeasurementsData userMeasurementData;
  final List<String> photoUrls;
  final VoidCallback onCommentBoxPressed;

  const DetailedPostScrollableCard(
      {Key key,
      this.userMeasurementData,
      this.photoUrls,
      this.onCommentBoxPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollableCard(
        child: DetailedPostScrollableCardContent(
      photoUrls: photoUrls,
      userMeasurementData: userMeasurementData,
      onCommentButtonPressed: onCommentBoxPressed,
    ));
  }
}
