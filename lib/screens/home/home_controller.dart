import '../../core/interfaces/controller_int.dart';
import 'package:logging/logging.dart';

import '../../core/utils_and_services/timatic/artemis_timatic.dart';
import '../../initialize.dart';
import 'home_state.dart';

class HomeController extends ControllerInterface {
  final _log = Logger('HomeController');
  late TimaticApi timaticApi = getIt<TimaticApi>();


  void clear() {
    ref.read(passengerProvider.notifier).update((s) => PassengerDetails());
    ref.read(visasProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(passportsProvider.notifier).update((s) => [DocumentDetail()]);
    ref.read(segmentsProvider.notifier).update((s) => [ItinerarySegment.empty()]);
  }
  // UseCase UseCase = UseCase(repository: Repository());
}
