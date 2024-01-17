package ru.practicum.ewm.stats.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import ru.practicum.ewm.dto.stats.EndpointHitDto;
import ru.practicum.ewm.dto.stats.ViewStatsDto;
import ru.practicum.ewm.stats.service.EndpointHitService;

import java.util.List;

@RestController
@RequestMapping
@RequiredArgsConstructor
@Slf4j
public class StatServiceController {
    private final EndpointHitService endpointHitService;

    @PostMapping("/hit")
    public void saveHit(@RequestBody EndpointHitDto endpointHitDto) {
        log.info("Получен запрос POST /stats — добавление сведений о статистике");
        endpointHitService.saveHit(endpointHitDto);
    }

    @GetMapping("/stats")
    public List<ViewStatsDto> getHit(@RequestParam String start, @RequestParam String end,
                                    @RequestParam(required = false) String[] uris,
                                    @RequestParam(required = false, defaultValue = "false") boolean unique) {
        log.info("Получен запрос GET /stats — получение сведений о статистике");
        return endpointHitService.getHit(start, end, uris, unique);
    }

}