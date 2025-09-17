package com.boots.poc.exemptions.repo;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.boots.poc.exemptions.model.EligibilityRule;

public interface EligibilityRuleRepository extends JpaRepository<EligibilityRule, Long>{

	@Query("""
		select r from EligibilityRule r
		where r.enabled = true
		and r.exemptionCode = :code
		and (
			r.storeId = :storeId
			or (
				r.regionId = (select s.regionId from Store s where s.id = :storeId)
				and not exists (select 1 from EligibilityRule rs where rs.enabled = true and rs.exemptionCode=:code and rs.storeId=:storeId)
			)
		)
		and (r.validFrom is null or r.validFrom <= :asOf)
		and (r.validTo is null or r.validTo >= :asOf)
		order by r.priority desc
	""")
	List<EligibilityRule> findEffective(@Param("storeId") Long storeId,
			@Param("code") String code,
			@Param("asOf") LocalDate asOf);

}
