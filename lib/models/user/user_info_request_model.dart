class UserInitialInfoRequest {
  final String userIdx, profileImg, interest, avgSpeed, preferArea, mbti, userIntroduce, hateFood, taste;

  UserInitialInfoRequest.fromJson(Map<String, dynamic> json)
    : userIdx = json['userIdx'],
      profileImg = json['profileImg'],
      taste = json['taste'],
     hateFood = json['hateFood'],
     interest = json['interest'],
     avgSpeed = json['avgSpeed'],
     preferArea = json['preferArea'],
     mbti = json['mbti'],
     userIntroduce = json['userIntroduce'];
}