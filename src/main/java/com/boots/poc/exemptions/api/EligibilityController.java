package com.boots.poc.exemptions.api;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.boots.poc.exemptions.service.EligibilityService;

@RestController
@RequestMapping("api/eligibility")
public class EligibilityController {

	private final EligibilityService svc;
	public EligibilityController(EligibilityService svc) {
		this.svc = svc;
	}
	
	@GetMapping
	public EligibilityResult check(@RequestParam ("storeId") Long storeId,
			@RequestParam (name = "exemptionCode") String exemptionCode,
			@RequestParam (name = "dob") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) String dob,
			@RequestParam(name="sex", defaultValue = "ANY") String sex,
			@RequestParam(name="asOf", required=false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) String asOf) {
		var when = (asOf == null) ? LocalDate.now() : LocalDate.parse(asOf);
		PersonFacts facts = new PersonFacts(LocalDate.parse(dob), sex, when);
		return svc.checkSpa(facts);
	}
}
