import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadball_manager/models/models.dart';
import 'package:quadball_manager/services/userloc_repository_base.dart';

class UserLocCubit extends Cubit<UserLocState> {
  final UserLocRepositoryBase _userLocRepository;

  File? _pickedImage;
  UserLoc? _user;

  UserLocCubit(this._userLocRepository) : super(UserLocLoadingState());

  void setImage(File? imageFile) {
    _pickedImage = imageFile;
    emit(UserLocReadyState.image(_user!, _pickedImage));
  }

  Future<void> getUserLoc() async {
    emit(UserLocLoadingState());
    _user = await _userLocRepository.getUserLoc();
    _user ??= const UserLoc('', '', '', 0, '', '', '', [], []);
    emit(UserLocReadyState(_user!, _pickedImage));
  }

  Future<void> saveUserLoc(
      String id,
      String name,
      String lastName,
      int age,
      String gender,
      String rol,
      List<dynamic>? positions,
      List<dynamic>? arbitrageTitles) async {
    _user = UserLoc(id, name, lastName, age, gender, rol, _user!.image,
        positions, arbitrageTitles);
    emit(UserLocReadyState(_user, _pickedImage, isSaving: true));
    await _userLocRepository.saveUserLoc(_user!, _pickedImage);
    emit(UserLocReadyState(_user, _pickedImage, isSaving: false));
  }
}

abstract class UserLocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLocLoadingState extends UserLocState {}

class UserLocReadyState extends UserLocState {
  final UserLoc? user;
  final File? pickedImage;
  final bool isSaving;

  UserLocReadyState(this.user, this.pickedImage, {this.isSaving = false});

  UserLocReadyState.image(this.user, this.pickedImage, {this.isSaving = false});

  @override
  List<Object?> get props => [user, pickedImage?.path, isSaving];
}
