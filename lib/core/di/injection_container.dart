import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/features/login/data/datasource/login_service.dart';
import 'package:clients_manager/features/login/data/repository/login_repository_impl.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';
import 'package:clients_manager/features/login/domain/usecase/create_login_request_use_case.dart';
import 'package:clients_manager/features/login/domain/usecase/login_use_case.dart';
import 'package:clients_manager/features/register/data/datasource/register_service.dart';
import 'package:clients_manager/features/register/data/repository/register_repository_impl.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';
import 'package:clients_manager/features/register/domain/usecase/create_register_request_use_case.dart';
import 'package:clients_manager/features/register/domain/usecase/register_use_case.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  late final HttpService httpService;

  // Login
  late final LoginService loginService;
  late final LoginRepository loginRepository;
  late final LoginUseCase loginUsecase;
  late final CreateLoginRequestUseCase createLoginRequestUseCase;

  late final RegisterService registerService;
  late final RegisterRepository registerRepository;
  late final RegisterUseCase registerUseCase;
  late final CreateRegisterRequestUseCase createRegisterRequestUseCase;

  Future<void> init() async {
    httpService = HttpService(
      baseURL: ApiData.base_URL,
      timeOut: Duration(seconds: 5),
    );

    loginService = LoginService(httpService: httpService);
    loginRepository = LoginRepositoryImpl(loginService: loginService);
    loginUsecase = LoginUseCase(loginRepository: loginRepository);
    createLoginRequestUseCase = CreateLoginRequestUseCase();

    registerService = RegisterService(httpService: httpService);
    registerRepository = RegisterRepositoryImpl(
      registerService: registerService,
    );
    registerUseCase = RegisterUseCase(registerRepository: registerRepository);
    createRegisterRequestUseCase = CreateRegisterRequestUseCase();
  }
}
