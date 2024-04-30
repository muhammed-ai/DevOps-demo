 # Test Cases

This document contains the test cases executed for this module.

## Positive Test Cases
|          Test case                 |    Inputs                | Expected Results |    Actual Results              |Passed/Failed |
|------------------------------------|--------------------------|------------------|--------------------------------|--------------|
|   Valid Subnet_names               |"private-1"               |Novalidationerrors|  "private-1"                   |   Passed     |
|   Valid vnet                       |"vnet-foundation-nonprod" |Novalidationerrors|  "vnet-foundation-nonprod"     |   Passed     |
|   ValidProjectandEnvironment       |"cloudops"                |Novalidationerrors|  "ftw-rg-cloudops-nonprod-vrbv"|   Passed     |
|   Resource group                   | Null                     |   Creating       |  "ftw-rg-cloudops-nonprod-vrbv"|   Passed     | 



## Negative Test Cases

|    Test case      |    Inputs        | Expected Results |      Actual Results              | Passed/Failed |
|  --------------   |------------      |------------------|  ------------------------        |---------------|
|InValid vnet       |     ""           | Validation Error | Value must be a valid vnet name  |     Failed    |
|  EmptySubnets     |     {}           | Validation Error | Value must not be empty          |     Failed    |
| Invalid Project   |     ""           | Validation Error | Value must not be empty          |     Failed    
|Invalid Environment|  "staging"       | Validation Error | Value must be one of dev, test, nonprod or prod         |     Failed    |
| Resource Group    |  Non-existing    |                  | value must be null or existing   |     Failed    |
