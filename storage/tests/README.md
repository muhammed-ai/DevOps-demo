 # Test Cases
 # Basic test case with no arguments (should return help message)

This document contains the test cases executed for this module. 

## Positive Test Cases
|          Test case       |    Inputs   | Expected Results |    Actual Results       | Passed/Failed |
|--------------------------|-------------|------------------|-------------------------|---------------|
| Disable public access    | allow_nested_items_to_be_public = false |allow only ip_rules = ["100.0.0.1"] | allow only bnsf-vm-network | PASSED |
| Storage account name     | No Arguments| unique name |  stcloudopsnonprodsapiyx                                                      | PASSED |
| resource group provided? | Null        | create new rg     | "rg-cloudops-nonprod-sa"                                                | PASSED |
| Resource group           | existing rg | execute using rg  | "rg-cloudops-nonprod-sa"                                                | PASSED |


## Negative Test Cases 

|    Test case      |    Inputs   | Expected Results |      Actual Results              | Passed/Failed |
|  --------------   |------------ |------------------|  ------------------------        |---------------|
| public access |public_network_access_enabled = false | Error | policy enforced to disallow public network access | Failed |
| Resource group | non-existing rg   | value must be null or existing rg | rg not found | FAILED |
| Invalid Project   |     " "           | Validation Error | Value must not be empty          |     Failed    |
| ip_rules     |  " "  | Validation Error | Value must start with IPV4 address and/or slash, number of bits (0-30) as prefix.  |     Failed    |
