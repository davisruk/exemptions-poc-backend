package com.boots.poc.exemptions.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boots.poc.exemptions.api.ExemptionEntryDto;
import com.boots.poc.exemptions.model.Exemption;
import com.boots.poc.exemptions.repo.ExemptionRepository;

@Service
@Transactional(readOnly = true)
public class ExemptionService {
	private final ExemptionRepository exemptions;

	public ExemptionService(ExemptionRepository exemptions) {
		this.exemptions = exemptions;
	}

	public List<Exemption> getEffectiveExemptions(Long storeId) {
		return exemptions.findEffectiveForStore(storeId);
	}

	public Page<ExemptionEntryDto> fetchExemptionPage(Long storeId, Pageable page) {
		return exemptions.findExemptionsForStorePage(storeId, page);
	}
}
