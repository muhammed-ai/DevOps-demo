 # Test Cases

**This Table contains the test cases executed for Linux Virtual Machine module.**



## Positive Test Cases
|          Test case               |             Inputs                  | Expected Results   |                    Actual Results                          |Passed/Failed|
|----------------------------------|-------------------------------------|--------------------|------------------------------------------------------------|-------------|
|Valid VNet Name                   |   "vnet-platformdep-nonprod-sc01"   |No validation errors|         "vnet-platformdep-nonprod-sc01"                    |Passed       |
|Valid Project and Environment name|       "cloudops", "nonprod"         |No validation errors|                "vm-cloudops-non"                           |Passed       |
|Valid Subnet Name                 |     "platformdep-nonprod-subnet"    |No validation errors|           "platformdep-nonprod-subnet"                     |Passed       |
|Valid Additional Tags             |"EnterpriseCloudOps@bnsf.com","80219"|No validation errors|"Owner"= "EnterpriseCloudOps@bnsf.com""CostCenter" = "80219"|Passed       |

**Linux Virtual Machine Positive Test Case**




## Negative Test Cases

|             Test case            |       Inputs        |Expected Results |                                      Actual Results                                        |Passed/Failed|
|----------------------------------|---------------------|-----------------|--------------------------------------------------------------------------------------------|-------------|
|Empty VNet Name                   |       “”            |Validation errors|Error: “The vnet_name value must not be empty."                                             |Failed       |
|Empty Project and Environment name|     “” ,“”          |Validation errors|Error: "The project value must not be empty,The environment value must be non ,dev…or prod" |Failed       |
|Empty Subnet Name                 |       “”            |Validation errors|Error: “The network_config value must not be empty."                                        |Failed       |
|Tags Exceeding Character Limit    |adb...etc, abcd...etc|Validation errors|Error: “The additional_tags keys…256 characters.”,“The additional_tags keys…256 characters.”|Failed       |

**Linux Virtual Machine Negative Test Case**
