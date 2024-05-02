import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class AuthCubit extends Cubit<AuthState> {
  final CreateUserUseCase _createUserUseCase;
  final CreateRestaurantUseCase _createRestaurantUseCase;
  final UpdateRestaurantUseCase _updateRestaurantUseCase;
  final CreateCategoryUseCase _createCategoryUseCase;
  final CreateProductUseCase _createProductUseCase;
  final GetUserUseCase _getUserUseCase;
  final GetAddressByZipCodeUseCase _getAddressByZipCodeUseCase;
  final GetAddressUseCase _getAddressUseCase;
  final CreateAddressUseCase _createAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  AuthCubit(
    this._createUserUseCase,
    this._createRestaurantUseCase,
    this._updateRestaurantUseCase,
    this._createCategoryUseCase,
    this._createProductUseCase,
    this._getUserUseCase,
    this._getAddressByZipCodeUseCase,
    this._getAddressUseCase,
    this._createAddressUseCase,
    this._updateAddressUseCase,
    this._uploadImageUseCase,
  ) : super(AuthState()) {
    init();
  }

  init() async {
    // await createProduct(
    //   restaurantId: 1.toString(),
    //   categoryId: '01ac840c-982e-41c4-850e-2f7c6661b3d6',
    //   name: '4',
    //   image: [
    //     'https://firebasestorage.googleapis.com/v0/b/minhaloja-77c99.appspot.com/o/4.png?alt=media&token=f4670c3d-43f2-443c-a789-65cd3f19c693'
    //   ],
    //   value: 100,
    //   description:
    //       'Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
    // );
  }

  Future<void> loginAnonymous() async {
    try {
      if (Uri.base.host != 'localhost') {
        final firebase = FirebaseAuth.instance;
        var user = firebase.currentUser;
        if (user == null) {
          final userAnonymously = await firebase.signInAnonymously();
          user = userAnonymously.user;
          await createUser(
            authToken: user!.uid,
            email: '',
            phoneNumber: '',
            username: '',
            password: '',
            isAnonymous: true,
          );
          debugPrint(
              "Created and Signed in with temporary account. ${user.uid.toString()}");
        } else {
          await getUser(authToken: user.uid);
          debugPrint(
              "Signed in with temporary account. ${state.user?.authToken.toString()}");
        }
      } else {
        debugPrint(Uri.base.host);
        await getUser(authToken: 'RsaWUkfdpsX3MRF7VWfEiNiwvNH3');
        debugPrint(
            "Signed in with temporary account localhost. ${state.user?.authToken.toString()}");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
  }

  Future<bool> getUser({
    required String authToken,
  }) async {
    update(loading: true);

    final request = await _getUserUseCase(authToken: authToken);

    request.result(
      (user) {
        emit(state.copyWith(user: user));
        update(actions: {AuthAction.userSuccessfully});
        return true;
      },
      (e) {
        update(failure: e);
        return false;
      },
    );
    return false;
  }

  Future<void> createUser({
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    required String? authToken,
    required bool? isAnonymous,
  }) async {
    update(loading: true);

    final user = authToken != null
        ? UserDTO(
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            password: password,
            authToken: authToken,
            isAnonymous: isAnonymous,
          )
        : UserDTO(
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            password: password,
          );

    // criar user no firebase
    final request = await _createUserUseCase(user: user);

    request.result(
      (_) {
        emit(
          state.copyWith(user: user),
        );
        update(
          actions: {AuthAction.userSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> createRestaurant({
    required UserEntity user,
    required String userId,
    required String cnpj,
    required String phoneNumber,
    required String url,
    required String logoUrl,
    required String backgroundUrl, // TODO: Ajustar
    required String name,
    required String description,
    required String segment,
    required String city,
    required String complement,
    required String country,
    required String neighborhood,
    required String number,
    required String street,
    required String zipCode,
    required String stateCountry,
  }) async {
    update(loading: true);

    // final restaurant = RestaurantRequestDTO(
    //   address: AddressDTO(
    //     city: city,
    //     complement: complement,
    //     country: country,
    //     neighborhood: neighborhood,
    //     number: number,
    //     street: street,
    //     zipCode: zipCode,
    //     state: stateCountry,
    //   ),
    //   banner: [],
    //   user: user,
    //   userId: userId,
    //   cnpj: cnpj,
    //   phoneNumber: phoneNumber,
    //   url: url,
    //   logoUrl: PathImages.iconRestaurant,
    //   backgroundUrl: PathImages.pizza,
    //   name: name,
    //   description: description,
    //   segment: segment,
    // );

    // ignore: unused_local_variable
    final requestUploadImage = await _uploadImageUseCase(
      path: logoUrl,
      storageType: StorageType.store,
    );

    update(loading: false);

    // final request = await _createRestaurantUseCase(restaurant: restaurant);

    // request.result(
    //   (_) {
    //     emit(state.copyWith(restaurant: restaurant));
    //     update(actions: {AuthAction.restaurantSuccessfully});
    //     update(loading: false);
    //   },
    //   (e) => update(failure: e, loading: false),
    // );
  }

  Future<void> updateRestaurant({
    required UserEntity user,
    required String id,
    required String userId,
    required String addressId,
    required String cnpj,
    required String phoneNumber,
    required String url,
    required String? logoUrl, // TODO: Ajustar
    required String? backgroundUrl, // TODO: Ajustar
    required String name,
    required String description,
    required String segment,
    required String city,
    required String complement,
    required String country,
    required String neighborhood,
    required String number,
    required String street,
    required String zipCode,
    required String stateCountry,
  }) async {
    // Sempre mandar o ID do restaurante
    final restaurant = RestaurantRequestDTO(
      address: AddressDTO(
        id: addressId,
        city: city,
        complement: complement,
        country: country,
        neighborhood: neighborhood,
        number: number,
        street: street,
        zipCode: zipCode,
        state: stateCountry,
      ),
      banner: [],
      id: id,
      user: user,
      userId: userId,
      cnpj: cnpj,
      phoneNumber: phoneNumber,
      url: url,
      logoUrl: PathImages.iconRestaurant,
      backgroundUrl: PathImages.pizza,
      name: name,
      description: description,
      segment: segment,
    );

    final request = await _updateRestaurantUseCase(restaurant: restaurant);

    request.result(
      (_) {
        emit(state.copyWith(restaurant: restaurant));
        update(actions: {AuthAction.updateRestaurantSuccessfully});
      },
      (e) => update(failure: e),
    );
  }

  Future<void> createCategory({
    required String name,
    required String restaurantId,
  }) async {
    update(loading: true);

    var category = CategoryDTO(
      name: name,
      restaurantId: restaurantId,
    );

    final request = await _createCategoryUseCase(category: category);

    request.result(
      (_) {
        update(
          actions: {AuthAction.categorySuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> createProduct({
    required String restaurantId,
    required String categoryId,
    required String name,
    required List<String> image,
    required double value,
    required String description,
  }) async {
    update(loading: true);

    var product = ProductDTO(
      categoryId: categoryId,
      name: name,
      restaurantId: restaurantId,
      description: description,
      value: value,
      image: image,
      combos: [],
    );

    final request = await _createProductUseCase(product: product);

    request.result(
      (_) {
        update(
          actions: {AuthAction.productSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> uploadFile() async {
    // https://pt.stackoverflow.com/questions/180939/recuperar-imagem-do-firebase-storage-sem-fazer-download
  }

  Future<void> setShowAddressInput(
    String zipCode,
  ) async {
    update(loading: true);
    zipCode = zipCode.extractNumbers();

    if (zipCode.length == 8 &&
        (zipCode != (state.address?.zipCode.extractNumbers() ?? ''))) {
      FocusManager.instance.primaryFocus!.unfocus();
      final request = await _getAddressByZipCodeUseCase(
        zipCode: zipCode,
      );

      request.result(
        (address) {
          AddressDTO? addressDTO = address != null
              ? AddressDTO(
                  country: 'Brasil',
                  number: '',
                  zipCode: address.zipCode.extractNumbers(),
                  street: address.street,
                  state: address.state.toUpperCase(),
                  city: address.city,
                  neighborhood: address.neighborhood,
                  complement: '',
                )
              : null;
          emit(
            state.copyWith(address: addressDTO),
          );
          update(
            actions: address != null ? {AuthAction.cepSuccessfully} : {},
          );
        },
        (error) {
          update(failure: error);
        },
      );
    }
  }

  Future<void> getAddress({
    required String userId,
  }) async {
    update(loading: true);

    final request = await _getAddressUseCase(userId: userId);

    request.result(
      (address) {
        emit(
          state.copyWith(userAddress: address),
        );
        update(
          actions: {AuthAction.addressSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> createAddress({
    required AddressDTO address,
  }) async {
    update(loading: true);

    final request = await _createAddressUseCase(
      userId: state.user?.id ?? '',
      address: address,
    );

    request.result(
      (_) {
        emit(
          state.copyWith(userAddress: address),
        );
        update(
          actions: {AuthAction.createAddressSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  Future<void> updateAddress({
    required AddressDTO address,
  }) async {
    update(loading: true);

    final request = await _updateAddressUseCase(
      addressId: state.userAddress?.id ?? '',
      address: address,
    );

    request.result(
      (_) {
        emit(
          state.copyWith(userAddress: address),
        );
        update(
          actions: {AuthAction.updateAddressSuccessfully},
        );
      },
      (e) => update(failure: e),
    );
  }

  bool validateUserAddress() {
    return state.userAddress?.city == '' ||
        state.userAddress?.country == '' ||
        state.userAddress?.neighborhood == '' ||
        state.userAddress?.number == '' ||
        state.userAddress?.state == '' ||
        state.userAddress?.street == '' ||
        state.userAddress?.zipCode == '' ||
        state.userAddress == null;
  }

  void update({
    bool loading = false,
    Failure? failure,
    Set<AuthAction>? actions,
  }) {
    Set<AuthAction> newActions = actions ??
        state.actions.difference(
          {
            AuthAction.creating,
          },
        );
    if (loading) {
      newActions = newActions.union({AuthAction.creating});
    }
    emit(
      state.copyWith(
        actions: newActions,
        failure: failure,
      ),
    );
  }
}
