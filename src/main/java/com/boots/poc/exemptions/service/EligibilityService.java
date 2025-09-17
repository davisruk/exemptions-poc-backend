package com.boots.poc.exemptions.service;

import java.time.LocalDate;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.boots.poc.exemptions.api.EligibilityResult;
import com.boots.poc.exemptions.api.PersonFacts;
import com.boots.poc.exemptions.model.EligibilityRule;
import com.boots.poc.exemptions.repo.EligibilityRuleRepository;
import com.boots.poc.exemptions.repo.PensionSpaByDobRepository;
import com.boots.poc.exemptions.repo.StoreRepository;

@Service
public class EligibilityService {
	private final EligibilityRuleRepository rules;
	private final PensionSpaByDobRepository spa;
	private final StoreRepository stores;
	
	public EligibilityService(EligibilityRuleRepository rules, PensionSpaByDobRepository spa, StoreRepository stores) {
		this.stores = stores;
		this.spa = spa;
		this.rules = rules;
	}
	
	@Transactional(readOnly=true)
	public EligibilityResult qualifies(Long storeId, String exemptionCode, PersonFacts person, LocalDate asOf) {
		if (asOf == null) asOf = LocalDate.now();
		
		var rule = rules.findEffective(storeId, exemptionCode, asOf).stream().findFirst().orElse(null);
		if (rule == null) return new EligibilityResult(true, "No rule for exemption; allow", null);
		
		return switch (rule.getKind()) {
			case "SPA_DOB" -> evalSpaDob(rule, storeId, person, asOf);
			default -> new EligibilityResult(true, "Unknown rule kind; allow", null);
		};
	}
	
	private EligibilityResult evalSpaDob (EligibilityRule rule, Long storeId, PersonFacts person, LocalDate asOf) {
		Long regionId = stores.findRegionIdByStoreId(storeId).orElseThrow();
		Long scheduleStore = (rule.getStoreId() != null) ? rule.getStoreId() : null;
		Long scheduleRegion = (scheduleStore == null) ? rule.getRegionId() : null;
		if (scheduleStore == null && scheduleRegion == null) scheduleRegion = regionId;
		
		var row = spa.findApplicable(scheduleRegion, scheduleStore, person.sex(), person.dob()).stream().findFirst().orElse(null);
		if (row == null)
			return new EligibilityResult(false, "No SPA schedule for DOB=%s".formatted(person.dob()), null);
		
		LocalDate spaDate = (row.getSpaFixedDate() != null)
				? row.getSpaFixedDate()
				: person.dob().plusYears(row.getSpaAgeYears()).plusMonths(row.getSpaAgeMonths());
		
		boolean ok = !asOf.isBefore(spaDate);
		String scope = (scheduleStore != null) ? "store" : "region";
		String because = (row.getSpaFixedDate() != null)
			? "SPA on fixed date %s for DOB band; %s-scoped".formatted(spaDate, scope)
			: "SPA at %dy%dm -> %s; %s-scoped".formatted(row.getSpaAgeYears(), row.getSpaAgeMonths(), spaDate, scope);
		return new EligibilityResult(ok, because, spaDate);
	}
}
