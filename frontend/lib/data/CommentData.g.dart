// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return CommentData(
    json['commentId'] as String,
    json['comment'] as String,
    json['publicUserProfileData'] == null
        ? null
        : PublicUserProfileData.fromJson(
            json['publicUserProfileData'] as Map<String, dynamic>),
    json['createdAt'] as String,
    (json['userIdLikes'] as List)?.map((e) => e as String)?.toList(),
    json['isLiked'] as bool,
  );
}

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'comment': instance.comment,
      'publicUserProfileData': instance.publicUserProfileData,
      'createdAt': instance.createdAt,
      'userIdLikes': instance.userIdLikes,
      'isLiked': instance.isLiked,
    };
