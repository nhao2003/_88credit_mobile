import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../../di/injection_container.dart';
import '../../../../domain/entities/bank.dart';
import '../../../../domain/entities/bank_card.dart';
import '../../../../domain/usecases/bank/add_bank_card.dart';
import '../../../../domain/usecases/bank/delete_bank_card.dart';
import '../../../../domain/usecases/bank/get_bank_cards.dart';
import '../../../../domain/usecases/bank/mark_as_primary_bank_card.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankBloc() : super(const BankState()) {
    on<BankEvent>((event, emit) {});
    on<GetBankCard>(getBankCard);
    on<MarkAsPrimaryCard>(markAsPrimaryCard);
    on<ChangeSelectedBank>((event, emit) {
      emit(state.copyWith(selectedBank: event.bank));
    });
    on<AddBankCard>(addBankCard);
    on<DeleteBankCard>(deleteBankCard);
  }

  // get bank card
  final GetBankCardsUseCase getBankCardsUseCase = sl<GetBankCardsUseCase>();
  Future<void> getBankCard(GetBankCard event, Emitter<BankState> emit) async {
    emit(state.copyWith(getBankCardStatus: GetBankCardStatus.loading));
    try {
      final result = await getBankCardsUseCase();
      emit(state.copyWith(
        getBankCardStatus: GetBankCardStatus.success,
        listBankCards: [...result],
      ));
    } catch (e) {
      emit(state.copyWith(getBankCardStatus: GetBankCardStatus.error));
    }
  }

  //  mark as primary card
  MarkAsPrimaryBankCardsUseCase markAsPrimaryBankCardsUseCase =
      sl<MarkAsPrimaryBankCardsUseCase>();
  Future<void> markAsPrimaryCard(
      MarkAsPrimaryCard event, Emitter<BankState> emit) async {
    emit(state.copyWith(
        markAsPrimaryBankCardStatus: MarkAsPrimaryBankCardStatus.loading));
    try {
      EasyLoading.show(status: 'loading...');
      await markAsPrimaryBankCardsUseCase(params: event.idCard);
      emit(state.copyWith(
          markAsPrimaryBankCardStatus: MarkAsPrimaryBankCardStatus.success,
          listBankCards: [...await getBankCardsUseCase()]));
      EasyLoading.dismiss();
    } catch (e) {
      emit(state.copyWith(
          markAsPrimaryBankCardStatus: MarkAsPrimaryBankCardStatus.error));
      EasyLoading.dismiss();
    }
  }

  // add bank Card
  AddBankCardUseCase addBankCardUseCase = sl<AddBankCardUseCase>();
  Future<void> addBankCard(AddBankCard event, Emitter<BankState> emit) async {
    emit(state.copyWith(addBankCardStatus: AddBankCardStatus.loading));
    try {
      print("Card number: ${event.cardNumber}");
      await addBankCardUseCase(
          params: createBankCardEntity(state.selectedBank, event.cardNumber));
      emit(state.copyWith(
          addBankCardStatus: AddBankCardStatus.success,
          listBankCards: [...await getBankCardsUseCase()]));
    } catch (e) {
      emit(state.copyWith(addBankCardStatus: AddBankCardStatus.error));
      EasyLoading.dismiss();
    }
  }

  BankCardEntity createBankCardEntity(
      BankEntity? selectedBank, String cardNumber) {
    return BankCardEntity(
      bank: selectedBank,
      bankId: selectedBank!.id,
      cardNumber: cardNumber,
      isPrimary: false,
    );
  }

  // delete bank card
  DeleteBankCardUseCase deleteBankCardUseCase = sl<DeleteBankCardUseCase>();
  Future<void> deleteBankCard(
      DeleteBankCard event, Emitter<BankState> emit) async {
    emit(state.copyWith(
        deleteBankCardStatus: DeleteBankCardStatus.loading,
        listBankCards: [...await getBankCardsUseCase()]));
    try {
      EasyLoading.show(status: 'Đang cập nhập');
      await deleteBankCardUseCase(params: event.card);
      emit(state.copyWith(
          deleteBankCardStatus: DeleteBankCardStatus.success,
          listBankCards: [...await getBankCardsUseCase()]));
      EasyLoading.dismiss();
    } catch (e) {
      emit(state.copyWith(deleteBankCardStatus: DeleteBankCardStatus.error));
    }
  }
}
