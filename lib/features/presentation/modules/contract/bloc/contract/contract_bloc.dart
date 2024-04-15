import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/resources/pair.dart';
import '../../../../../domain/entities/bank.dart';
import '../../../../../domain/entities/bank_card.dart';
import '../../../../../domain/entities/contract.dart';
import '../../../../../domain/entities/user.dart';
import '../../../../../domain/enums/loan_reason_types.dart';
import '../../../../../domain/enums/post_type.dart';
import '../../../../../domain/enums/role.dart';
import '../../../../../domain/enums/user_status.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc() : super(const ContractState()) {
    on<ContractEvent>((event, emit) {});
    on<RefreshContractEvent>(_refreshRequest);
    on<FetchMoreContractEvent>(_fetchMoreRequest);
  }

  Future<Pair<int, List<ContractEntity>>> _getLendingContracts() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getContracts(),
    );
  }

  Future<Pair<int, List<ContractEntity>>> _getBorrowingContracts() async {
    await Future.delayed(const Duration(seconds: 2));
    return Pair(
      1,
      getContracts(),
    );
  }

  List<ContractEntity> getContracts() {
    return List.generate(
      10,
      (index) => ContractEntity(
        id: index.toString(),
        loanContractRequestId: index.toString(),
        contractTemplateId: index.toString(),
        lenderBankCard: bankCard,
        borrowerBankCard: bankCard,
        lender: user,
        lenderBankCardId: index.toString(),
        borrower: user,
        borrowerBankCardId: index.toString(),
        loanReasonType: LoanReasonTypes.business,
        loanReason: 'Loan reason',
        amount: 1000,
        interestRate: 0.1,
        tenureInMonths: 12,
        overdueInterestRate: 0.2,
        createdAt: DateTime.now(),
        expiredAt: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }

  BankCardEntity get bankCard => BankCardEntity(
        id: '1',
        isPrimary: true,
        userId: '1',
        bankId: '1',
        cardNumber: '1234567890',
        branch: 'Branch',
        bank: bank,
        createdAt: DateTime.now(),
        deletedAt: null,
      );
  BankEntity get bank => const BankEntity(
        id: '1',
        name: 'Bank',
        shortName: 'Bank',
        logo:
            'https://baobitrungthanh.com/wp-content/uploads/2024/01/logo-ngan-hang-agribank-40.jpg',
        code: '123',
        bin: '123',
      );

  UserEntity get user => UserEntity(
        id: '1',
        status: UserStatus.verified,
        isIdentityVerified: true,
        role: Role.user,
        email: 'a@a.com',
        address: null,
        firstName: 'John',
        lastName: 'Doe',
        gender: true,
        avatar:
            'https://i.pinimg.com/736x/8a/6a/a8/8a6aa88d7b7efd82c7ddbf296dc401eb.jpg',
        dob: '1990-01-01',
        phone: '0123456789',
        lastActiveAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  int page = 1;
  int numOfPage = 1;
  bool hasMore = true;
  Future _refreshRequest(
      RefreshContractEvent event, Emitter<ContractState> emit) async {
    page = 1;
    hasMore = true;
    emit(state.copyWith(
      status: ContractFetchStatus.loading,
      hasMore: hasMore,
    ));

    final Pair<int, List<ContractEntity>> result;
    switch (event.contractType) {
      case PostTypes.lending:
        emit(state.copyWith(lendingContracts: []));
        result = await _getLendingContracts();
        break;
      case PostTypes.borrowing:
        emit(state.copyWith(borrowingContracts: []));
        result = await _getBorrowingContracts();
        break;
    }

    numOfPage = result.first;
    final newPosts = result.second;
    numOfPage == 1 ? hasMore = false : hasMore = true;

    emit(state.copyWith(
      status: ContractFetchStatus.success,
      hasMore: hasMore,
    ));
    switch (event.contractType) {
      case PostTypes.lending:
        return emit(state.copyWith(lendingContracts: newPosts));
      case PostTypes.borrowing:
        return emit(state.copyWith(borrowingContracts: newPosts));
    }
  }

  Future _fetchMoreRequest(
      FetchMoreContractEvent event, Emitter<ContractState> emit) async {
    if (page < numOfPage) {
      page++;
      emit(state.copyWith(
        status: ContractFetchStatus.loading,
      ));

      final Pair<int, List<ContractEntity>> result;
      switch (event.contractType) {
        case PostTypes.lending:
          result = await _getLendingContracts();
          state.lendingContracts.addAll(result.second);
          break;
        case PostTypes.borrowing:
          result = await _getBorrowingContracts();
          state.borrowingContracts.addAll(result.second);
          break;
      }

      numOfPage = result.first;
      hasMore = true;
      emit(state.copyWith(
        status: ContractFetchStatus.success,
        hasMore: hasMore,
      ));
      switch (event.contractType) {
        case PostTypes.lending:
          return emit(state.copyWith(lendingContracts: state.lendingContracts));
        case PostTypes.borrowing:
          return emit(
              state.copyWith(borrowingContracts: state.borrowingContracts));
      }
    } else {
      hasMore = false;
      emit(state.copyWith(
        status: ContractFetchStatus.success,
        hasMore: hasMore,
      ));
    }
  }
}
