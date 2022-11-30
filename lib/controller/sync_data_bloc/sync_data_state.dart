part of 'sync_data_bloc.dart';

abstract class SyncDataState {}

class SyncDataInitial extends SyncDataState {}

class SyncDataUploadingData extends SyncDataState {}

class SyncDataGettingData extends SyncDataState {}

class SyncDataSuccess extends SyncDataState {}

class NoInternet extends SyncDataState {}

class SyncDataError extends SyncDataState {}
