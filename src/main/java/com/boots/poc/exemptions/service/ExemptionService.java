package com.boots.poc.exemptions.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boots.poc.exemptions.model.Exemption;
import com.boots.poc.exemptions.repo.ExemptionRepository;
import com.boots.poc.exemptions.repo.StoreRepository;

@Service
@Transactional(readOnly = true)
public class ExemptionService {
	private final ExemptionRepository exemptions;
	private final StoreRepository stores;

	public ExemptionService(ExemptionRepository exemptions, StoreRepository stores) {
		this.exemptions = exemptions;
		this.stores = stores;
	}

	public List<Exemption> getEffectiveExemptions(Long storeId) {
		// One-query approach:
		return exemptions.findEffectiveForStore(storeId);

		// two-step approach:
		// if (exemptions.countByStoreId(storeId) > 0) return
		// exemptions.findByStoreId(storeId);
		// Long regionId = stores.findRegionIdByStoreId(storeId)
		// .orElseThrow(() -> new IllegalArgumentException("Store not found: " +
		// storeId));
		// return exemptions.findByRegionId(regionId);
	}
}
