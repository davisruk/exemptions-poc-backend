package com.boots.poc.exemptions.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.boots.poc.exemptions.api.StoreDto;
import com.boots.poc.exemptions.api.StoreHeaderDto;
import com.boots.poc.exemptions.model.Store;

public interface StoreRepository extends JpaRepository<Store, Long> {
	Optional<Store> findByName(String name);

	@Query("select s.regionId from Store s where s.id = :storeId")
	Optional<Long> findRegionIdByStoreId(@Param("storeId") Long storeId);

	@Query("""
			  select new com.boots.poc.exemptions.api.StoreDto(
			    s.id, s.name, s.regionId, r.name
			  )
			  from Store s, Region r
			  where r.id = s.regionId
			  order by s.name
			""")
	List<StoreDto> findAllSummaries();

	@Query("""
			  select new com.boots.poc.exemptions.api.StoreHeaderDto(
			    s.id, s.name, s.regionId, r.name
			  )
			  from Store s, Region r
			  where s.id = :storeId
			  and r.id = s.regionId
			""")

	Optional<StoreHeaderDto> findHeaderById(@Param("storeId") Long storeId);
}
