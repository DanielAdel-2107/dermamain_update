import 'package:derma/api/endPoints.dart';
import 'package:dio/dio.dart';

import '../client/dio_client.dart';
import '../client/dio_exception.dart';

class DioServices {
  final DioClient dioClient;

  DioServices({required this.dioClient});

  Future<Response> addFavoriteDoctor(int patientId, int doctorId) async {
    try {
      final Response response = await dioClient.post(
        '${Endpoints.addFavoriteDoctors}?patientId=$patientId&doctorId=$doctorId',
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<Response> getFavoriteDoctors(int patientId) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.getFavoriteDoctors}?id=$patientId',
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<Response> removeFavoriteDoctors(int patientId, int doctorId) async {
    try {
      final Response response = await dioClient.delete(
        '${Endpoints.removeFavoriteDoctors}?patientId=$patientId&doctorId=$doctorId',
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<Response> getTreatmentPlan(int patientId, int doctorId) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.getTreatmentPlan}?doctorId=$doctorId&patientId=$patientId',
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<Response> addMedicine(
      int patientId, int doctorId, Map medicine) async {
    try {
      final Response response = await dioClient.post(
          '${Endpoints.addMedicine}?doctorId=$doctorId&patientId=$patientId',
          data: medicine,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<Response> getDoctors(int patientId) async {
    try {
      final Response response = await dioClient.get(
        '${Endpoints.getAllDoctors}?id=$patientId',
      );
      return response;
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }
}
