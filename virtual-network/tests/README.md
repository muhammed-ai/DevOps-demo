 # Test Cases

This document contains the test cases executed for this module.

## Positive Test Cases
|          Test case       |    Inputs   | Expected Results |    Actual Results       | Passed/Failed |
|--------------------------|-------------|------------------|-------------------------|---------------|
|      Valid CIDR Range    |"10.0.0.0/16"|Novalidationerrors|    "10.0.0.0/16"        |     Passed    |
|        Valid Subnets     |"10.0.1.0/24"|Novalidationerrors|    "10.0.1.0/24"        |     Passed    |
|                          |"10.0.2.0/24"|                  |    "10.0.2.0/24"        |               |
|ValidProjectandEnvironment|"my-project" |Novalidationerrors|  "my-project-dev-vnet"  |     Passed    |
|                          |   "dev"     |                  | "my-project-dev-subnet" |               |


## Negative Test Cases

|    Test case      |    Inputs   | Expected Results |      Actual Results              | Passed/Failed |
|  --------------   |------------ |------------------|  ------------------------        |---------------|
|InValidCIDRRange   |"10.0.0.0/33"| Validation Error |   Value must be a valid CIDR     |     Failed    |
|  EmptySubnets     |     {}      | Validation Error |    Value must not be empty       |     Failed    |
| Invalid Project   |     ""      | Validation Error |    Value must not be empty       |     Failed    |
|Invalid Environment|  "staging"  | Validation Error |     Value must be one of         |     Failed    |
|                   |             |                  |    dev, test, nonprod or prod    |               |