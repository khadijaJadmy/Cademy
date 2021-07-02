
import 'package:crypto_wallet/bloc/student.action.dart';
import 'package:crypto_wallet/bloc/student.state.dart';
import 'package:crypto_wallet/enums/enums.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/repositories/student.repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';



class ProfessorsBloc extends Bloc<ProfessorsEvent, ProfessorsState> {
  ProfessorsRepository messagesRepository;

  ProfessorsBloc(
      {@required ProfessorsState initialState, @required this.messagesRepository})
      : super(initialState);

  @override
  Stream<ProfessorsState> mapEventToState(ProfessorsEvent event) async* {
    if (event is LoadAllProfessorsEvents) {
      yield ProfessorsState(
          requestState: RequestState.LOADING, pharmacies: state.pharmacies,currentMessageEvent: event,selectedMessages:state.selectedMessages  );
      try {
        List<Professor> data = await messagesRepository.allPharmacys();
        print("LOADIIIING");
        print(data);
        yield ProfessorsState(
            requestState: RequestState.LOADED,
            pharmacies: data,
            currentMessageEvent: event,selectedMessages:state.selectedMessages,currentContact: data[0] );
      } catch (e) {
        yield ProfessorsState(
            requestState: RequestState.ERROR,
            messageError: e.toString(),
            pharmacies: state.pharmacies,
            currentMessageEvent: event,selectedMessages:state.selectedMessages  );
      }
    }
      
  }
}
