 # Test Cases

This document contains the test cases executed for this module.

## Positive Test Cases
|          Test case       |    Inputs       | Expected Results |    Actual Results           | Passed/Failed |
|--------------------------|-----------------|------------------|-------------------------    |---------------|
|   Valid Subnet_names     |"bnsf-vm-subnet1"|Novalidationerrors|  "bnsf-vm-subnet1"          |     Passed    |
|   Valid vnet             |"bnsf-vm-network"|Novalidationerrors|  "bnsf-vm-network"          |     Passed    |
|ValidProjectandEnvironment|"my-project"     |Novalidationerrors|  "my-project-dev-kv-mlinx"  |     Passed    |
|  Resource group          |   Null          |  Creating        |  "cloudops-nonprod-rg"      |     Passed    |                                               
|  Resource group          | Existing RG     |  Executing       |   "keyvault-RG"             |     Passed    |



## Negative Test Cases

|    Test case      |    Inputs        | Expected Results |      Actual Results              | Passed/Failed |
|  --------------   |------------      |------------------|  ------------------------        |---------------|
|InValid vnet       |     ""           | Validation Error | Value must be a valid vnet name  |     Failed    |
|  EmptySubnets     |     {}           | Validation Error | Value must not be empty          |     Failed    |
| Invalid Project   |     ""           | Validation Error | Value must not be empty          |     Failed    |
|Invalid Object_ids |     {}           | Validation Error | Value must not be empty          |     Failed    |
|Invalid Environment|  "staging"       | Validation Error | Value must be one of dev, test, nonprod or prod         |     Failed    |
| Resource Group    |  Non-existing    |                  | value must be null or existing   |     Failed    |
| Storage Account name | {}            | Validation Error | Value must not be empty          |     Failed    |
