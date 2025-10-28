import 'package:clients_manager/features/clients_display/data/datasource/create_client_service.dart';
import 'package:clients_manager/features/clients_display/data/datasource/delete_client_service.dart';
import 'package:clients_manager/features/clients_display/data/datasource/get_page_clients_service.dart';
import 'package:clients_manager/features/clients_display/data/repository/api_clients_repository_impl.dart';
import 'package:clients_manager/features/clients_display/domain/repository/api_clients_repository.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/create_client/create_request_create_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/delete_client/create_request_delete_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/delete_client/delete_client_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/get_page_clients/create_request_get_page_clients_use_case.dart';
import 'package:clients_manager/features/clients_display/domain/usecase/get_page_clients/get_page_clients_use_case.dart';
import 'package:clients_manager/core/network/http_service.dart';
import 'package:clients_manager/core/network/values_objects/api_data.dart';
import 'package:clients_manager/features/login/data/datasource/login_service.dart';
import 'package:clients_manager/features/login/data/repository/login_repository_impl.dart';
import 'package:clients_manager/features/login/domain/repository/login_repository.dart';
import 'package:clients_manager/features/login/domain/usecase/create_request_login_use_case.dart';
import 'package:clients_manager/features/login/domain/usecase/login_use_case.dart';
import 'package:clients_manager/features/register/data/datasource/register_service.dart';
import 'package:clients_manager/features/register/data/repository/register_repository_impl.dart';
import 'package:clients_manager/features/register/domain/repository/register_repository.dart';
import 'package:clients_manager/features/register/domain/usecase/create_request_register_use_case.dart';
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
  late final CreateRequestLoginUseCase createRequestLoginUseCase;

  // Register
  late final RegisterService registerService;
  late final RegisterRepository registerRepository;
  late final RegisterUseCase registerUseCase;
  late final CreateRequestRegisterUseCase createRequestRegisterUseCase;

  // Clients Display
  late final GetPageClientsService getPageClientsService;
  late final ApiClientsRepository apiClientsRepository;
  late final GetPageClientsUseCase getPageClientsUseCase;
  late final CreateRequestGetPageClientsUseCase
  createRequestGetPageClientsUseCase;

  late final CreateClientService createClientService;
  late final CreateClientUseCase createClientUseCase;
  late final CreateRequestCreateClientUseCase createRequestCreateClientUseCase;

  late final DeleteClientService deleteClientService;
  late final DeleteClientUseCase deleteClientUseCase;
  late final CreateRequestDeleteClientUseCase createRequestDeleteClientUseCase;

  Future<void> init() async {
    httpService = HttpService(
      baseURL: ApiData.base_URL,
      timeOut: Duration(seconds: 5),
    );

    loginService = LoginService(httpService: httpService);
    loginRepository = LoginRepositoryImpl(loginService: loginService);
    loginUsecase = LoginUseCase(loginRepository: loginRepository);
    createRequestLoginUseCase = CreateRequestLoginUseCase();

    registerService = RegisterService(httpService: httpService);
    registerRepository = RegisterRepositoryImpl(
      registerService: registerService,
    );
    registerUseCase = RegisterUseCase(registerRepository: registerRepository);
    createRequestRegisterUseCase = CreateRequestRegisterUseCase();

    getPageClientsService = GetPageClientsService(httpService: httpService);
    createClientService = CreateClientService(httpService: httpService);
    deleteClientService = DeleteClientService(httpService: httpService);
    apiClientsRepository = ApiClientsRepositoryImpl(
      getPageClientsService: getPageClientsService,
      createClientService: createClientService,
      deleteClientService: deleteClientService,
    );

    getPageClientsUseCase = GetPageClientsUseCase(
      apiClientsRepository: apiClientsRepository,
    );
    createRequestGetPageClientsUseCase = CreateRequestGetPageClientsUseCase();

    createClientUseCase = CreateClientUseCase(
      apiClientsRepository: apiClientsRepository,
    );
    createRequestCreateClientUseCase = CreateRequestCreateClientUseCase();
    
    deleteClientUseCase = DeleteClientUseCase(
      apiClientsRepository: apiClientsRepository,
    );
    createRequestDeleteClientUseCase = CreateRequestDeleteClientUseCase();
  }
}
