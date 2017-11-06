package com.albedo.java.web.rest;

import com.albedo.java.util.domain.CustomMessage;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by lijie on 2017/3/2.
 */
public class ResultBuilder {
    public static ResponseEntity buildOk(String... messages) {
        return new ResponseEntity(CustomMessage.createSuccess(null, messages), HttpStatus.OK);
    }

    public static ResponseEntity buildOk(Object data, String... messages) {
        return new ResponseEntity(CustomMessage.createSuccess(data, messages), HttpStatus.OK);
    }

    public static ResponseEntity buildFailed(String... messages) {
        return buildFailed(null, messages);
    }

    public static ResponseEntity buildFailed(Object data, String... messages) {
        if (messages == null) {
            messages = new String[]{"failed"};
        }
        return new ResponseEntity(CustomMessage.createWarn(data, messages), HttpStatus.OK);
    }

    public static ResponseEntity buildDataOk(Object data) {
        String[] msg;
        if (data instanceof BindingResult) {
            List<String> errorsList = new ArrayList();
            BindingResult bindingResult = (BindingResult) data;
            errorsList.addAll(bindingResult.getAllErrors().stream().map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.toList()));
            data = null;
            msg = new String[errorsList.size()];
            msg = errorsList.toArray(msg);
        } else {
            msg = new String[]{"ok"};
        }
        return buildOk(data, msg);
    }

    public static ResponseEntity buildObject(Object data) {
        return new ResponseEntity(data, HttpStatus.OK);
    }

    public static <X> ResponseEntity<X> wrapOrNotFound(Optional<X> maybeResponse) {
        return wrapOrNotFound(maybeResponse, (HttpHeaders) null);
    }

    public static <X> ResponseEntity<X> wrapOrNotFound(Optional<X> maybeResponse, HttpHeaders header) {
        return (ResponseEntity) maybeResponse.map((response) -> {
            return ((ResponseEntity.BodyBuilder) ResponseEntity.ok().headers(header)).body(response);
        }).orElse(new ResponseEntity(HttpStatus.NOT_FOUND));
    }

}
