import 'package:opennutritracker/core/domain/entity/user_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_gender_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_pal_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_goal_entity.dart';
import 'package:opennutritracker/features/onboarding/domain/entity/user_activity_selection_entity.dart';
import 'package:opennutritracker/features/onboarding/domain/entity/user_gender_selection_entity.dart';
import 'package:opennutritracker/features/onboarding/domain/entity/user_goal_selection_entity.dart';

class UserDataMaskEntity {
  UserGenderSelectionEntity? gender;
  DateTime? birthday;
  double? height;
  double? weight;
  UserActivitySelectionEntity? activity;
  UserGoalSelectionEntity? goal;
  double? carbsPercentageGoal;
  double? fatsPercentageGoal;
  double? proteinsPercentageGoal;

  bool acceptDataCollection = false;

  UserDataMaskEntity(
      {this.gender,
      this.birthday,
      this.height,
      this.weight,
      this.activity,
      this.goal,
      this.carbsPercentageGoal,
      this.fatsPercentageGoal,
      this.proteinsPercentageGoal});

  bool checkDataProvided() {
    if (gender != null &&
        birthday != null &&
        height != null &&
        weight != null &&
        activity != null &&
        goal != null &&
        carbsPercentageGoal != null &&
        fatsPercentageGoal != null &&
        proteinsPercentageGoal != null){
      return true;
    } else {
      return false;
    }
  }

  UserEntity? toUserEntity() {
    if (!checkDataProvided()) {
      return null;
    }
    final userBirthday = birthday ?? DateTime.now(); // TODO
    final userHeight = height ?? 180;
    final userWeight = weight ?? 70;
    final userCarbsPercentageGoal = carbsPercentageGoal ?? 0.6;
    final userFatsPercentageGoal = fatsPercentageGoal ?? 0.25;
    final userProteinsPercentageGoal = proteinsPercentageGoal ?? 0.15;
    UserGenderEntity userGender;
    if (gender == UserGenderSelectionEntity.genderMale) {
      userGender = UserGenderEntity.male;
    } else {
      userGender = UserGenderEntity.female;
    }
    UserWeightGoalEntity userGoal;
    switch (goal) {
      case UserGoalSelectionEntity.loseWeight:
        userGoal = UserWeightGoalEntity.loseWeight;
        break;
      case UserGoalSelectionEntity.maintainWeight:
        userGoal = UserWeightGoalEntity.maintainWeight;
        break;
      case UserGoalSelectionEntity.gainWeigh:
        userGoal = UserWeightGoalEntity.gainWeight;
        break;
      case null:
        userGoal = UserWeightGoalEntity.maintainWeight;
    }
    UserPALEntity userPal;
    switch (activity) {
      case UserActivitySelectionEntity.sedentary:
        userPal = UserPALEntity.sedentary;
        break;
      case UserActivitySelectionEntity.lowActive:
        userPal = UserPALEntity.lowActive;
        break;
      case UserActivitySelectionEntity.active:
        userPal = UserPALEntity.active;
        break;
      case UserActivitySelectionEntity.veryActive:
        userPal = UserPALEntity.veryActive;
        break;
      case null:
        userPal = UserPALEntity.lowActive;
    }

    return UserEntity(
        birthday: userBirthday,
        heightCM: userHeight,
        weightKG: userWeight,
        gender: userGender,
        goal: userGoal,
        pal: userPal,
        carbsPercentageGoal: userCarbsPercentageGoal,
        fatsPercentageGoal: userFatsPercentageGoal,
        proteinsPercentageGoal: userProteinsPercentageGoal);
  }
}
