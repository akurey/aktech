package com.akurey.common.http.handlers;

import com.akurey.common.exceptions.AKException;

import io.micronaut.context.annotation.Requires;
import io.micronaut.core.bind.exceptions.UnsatisfiedArgumentException;
import io.micronaut.http.HttpRequest;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.annotation.Produces;
import io.micronaut.http.server.exceptions.ExceptionHandler;
import jakarta.inject.Singleton;

@SuppressWarnings("rawtypes")
@Produces
@Singleton
@Requires(classes = { UnsatisfiedArgumentException.class, ExceptionHandler.class })
public class AKExceptionHandler extends BaseExceptionHandler implements ExceptionHandler<AKException, HttpResponse> {

  @Override
  public HttpResponse handle(HttpRequest request, AKException exception) {

    return buildExceptionResponse(exception, request);
  }
}
