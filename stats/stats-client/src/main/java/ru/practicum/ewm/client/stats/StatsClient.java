package ru.practicum.ewm.client.stats;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.util.DefaultUriBuilderFactory;
import ru.practicum.ewm.dto.stats.EndpointHitDto;
import ru.practicum.ewm.dto.stats.HttpRequestDto;
import ru.practicum.ewm.stats.mapper.HttpRequestDtoMapper;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class StatsClient extends BaseClient {
    private static final String API_PREFIX_POST = "/hit";
    private static final String API_PREFIX_GET = "/stats";

    public StatsClient(@Value("${stats-server.url}") String serverUrl, RestTemplateBuilder builder) {
        super(
                builder
                        .uriTemplateHandler(new DefaultUriBuilderFactory(serverUrl))
                        .requestFactory(HttpComponentsClientHttpRequestFactory::new)
                        .build()
        );
    }

    public void saveHit(HttpRequestDto httpRequestDto) {
        EndpointHitDto endpointHitDto = HttpRequestDtoMapper.toEndpointHitDto(httpRequestDto);
        post(API_PREFIX_POST, endpointHitDto);
    }

    public ResponseEntity<Object> get(HttpServletRequest request) {
        Map<String, String[]> parameters = request.getParameterMap();
        return get(API_PREFIX_GET, parameters);
    }
}