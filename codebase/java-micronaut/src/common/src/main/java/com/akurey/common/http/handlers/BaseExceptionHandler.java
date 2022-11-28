package com.akurey.common.http.handlers;

import com.akurey.common.exceptions.AKBadRequestException;
import com.akurey.common.exceptions.AKException;
import com.akurey.common.exceptions.AKNotFoundException;
import com.akurey.common.exceptions.AKUnauthenticatedException;
import com.akurey.common.exceptions.AKUnauthorizedException;
import com.akurey.common.exceptions.errors.BadRequestError;
import com.akurey.common.exceptions.errors.CommonError;
import com.akurey.common.logs.AKLogger;
import com.akurey.common.models.RestResponse;

import io.micronaut.http.HttpRequest;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.HttpStatus;

public abstract class BaseExceptionHandler {

  protected HttpResponse<RestResponse<?>> buildExceptionResponse(Exception e, Object request) {

    AKLogger.logRequestFailure(this, e, request);

    RestResponse<?> response = new RestResponse<>();

    response.setErrorResponse(CommonError.NOT_HANDLED_ERROR.getCode(), CommonError.NOT_HANDLED_ERROR.getMessage());
    HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;

    return HttpResponse.status(status).body(response);
  }

  protected HttpResponse<RestResponse<?>> buildExceptionResponse(AKException e, Object request) {

    AKLogger.logRequestFailure(this, e, request);

    RestResponse<?> response = new RestResponse<>();
    response.setErrorResponse(e.getErrorCode(), e.getMessage());

    HttpStatus status;
    if (e instanceof AKBadRequestException) {
      status = HttpStatus.BAD_REQUEST;
    } else if (e instanceof AKUnauthenticatedException) {
      status = HttpStatus.UNAUTHORIZED;
    } else if (e instanceof AKUnauthorizedException) {
      status = HttpStatus.FORBIDDEN;
    } else if (e instanceof AKNotFoundException) {
      status = HttpStatus.NOT_FOUND;
    } else {
      status = HttpStatus.INTERNAL_SERVER_ERROR;
    }

    return HttpResponse.status(status).body(response);
  }

  protected HttpResponse<RestResponse<?>> handleBadRequest(HttpRequest<?> request, Exception exception,
      String message) {

    RestResponse<?> response = new RestResponse<>();

    response.setErrorResponse(BadRequestError.BAD_REQUEST_ERROR.getCode(),
        BadRequestError.BAD_REQUEST_ERROR.getMessage() + message);

    AKLogger.logRequestFailure(this, exception, request);

    return HttpResponse.status(HttpStatus.BAD_REQUEST).body(response);
  }

  @SuppressWarnings("rawtypes")
  protected HttpResponse handleBadRequest(HttpRequest request, Exception exception) {

    return handleBadRequest(request, exception, "");
  }
}
