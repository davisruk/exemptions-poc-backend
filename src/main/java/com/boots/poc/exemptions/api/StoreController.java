package com.boots.poc.exemptions.api;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.boots.poc.exemptions.repo.StoreRepository;

@RestController
@RequestMapping("/api/stores")
public class StoreController {
	private final StoreRepository stores;

	public StoreController(StoreRepository stores) {
		this.stores = stores;
	}

	@GetMapping
	public List<StoreDto> list() {
		return stores.findAllSummaries();
	}
}
