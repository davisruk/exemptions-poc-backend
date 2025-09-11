package com.boots.poc.exemptions.api;

import java.util.List;

public record ExemptionDto(
 Long storeId,
 String storeName,
 Long regionId,
 String regionName,
 List<ExemptionEntryDto> exemptions
) {}

