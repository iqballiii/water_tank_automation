import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'water_track_event.dart';
part 'water_track_state.dart';

class WaterTrackBloc extends Bloc<WaterTrackEvent, WaterTrackState> {
  WaterTrackBloc()
      : super(const WaterTrackState(status: WaterTrackStatus.initial)) {
    on<WaterTrackEvent>(updateWeather);
  }

  void updateWeather(
      WaterTrackEvent event, Emitter<WaterTrackState> emit) async {
    emit(const WaterTrackState(status: WaterTrackStatus.loading));
    Logger().f("inside the place ${event.waterLevel}");
    await Future.delayed(const Duration(milliseconds: 150));
    if (event.waterLevel != null) {
      emit(WaterTrackState(
          status: WaterTrackStatus.success, waterLevel: event.waterLevel));
    } else {
      emit(const WaterTrackState(
          status: WaterTrackStatus.failure,
          errorMessage: 'Couldn\'t update the water level value'));
    }
  }
}
