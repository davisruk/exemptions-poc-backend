package com.boots.poc.exemptions.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boots.poc.exemptions.model.Exemption;
import com.boots.poc.exemptions.repo.StoreRepository;
import com.boots.poc.exemptions.service.ExemptionService;

@RestController
@RequestMapping("/api/stores")
public class ExemptionController {

	private final ExemptionService service;
	private final StoreRepository stores;

	public ExemptionController(ExemptionService service, StoreRepository stores) {
		this.service = service;
		this.stores = stores;
	}

	@GetMapping("/{storeId}/exemptions")
	public ResponseEntity<ExemptionDto> getEffective(@PathVariable("storeId") Long storeId) {
		// header (store + region)
		StoreHeaderDto header = stores.findHeaderById(storeId)
				.orElseThrow(() -> new IllegalArgumentException("Store not found: " + storeId));

		// items
		List<ExemptionEntryDto> items = service.getEffectiveExemptions(storeId).stream().map(this::toEntry).toList();

		ExemptionDto body = new ExemptionDto(header.id(), header.name(), header.regionId(), header.regionName(), items);

		return ResponseEntity.ok(body);
	}

	private ExemptionEntryDto toEntry(Exemption e) {
		return new ExemptionEntryDto(e.getId(), e.getCode(), e.getName());
	}
}
