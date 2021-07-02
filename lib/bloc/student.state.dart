import 'package:crypto_wallet/bloc/student.action.dart';
import 'package:crypto_wallet/enums/enums.dart';
import 'package:crypto_wallet/model/Professor.dart';


class ProfessorsState {
  RequestState requestState;
  List<Professor> pharmacies;
  String messageError;
  ProfessorsEvent currentMessageEvent;
  List<Professor> selectedMessages=[];
  Professor currentContact;

  ProfessorsState({this.currentMessageEvent,this.messageError,this.pharmacies,this.requestState,this.selectedMessages,this.currentContact});

  ProfessorsState.initialState():
    requestState=RequestState.NONE,
    pharmacies=[],
    messageError='',
    currentMessageEvent=null,
    selectedMessages=[],
    currentContact=new Professor();


}