#################################
# Firewall Manager in eu-west-2 #
#################################

# Shield Advanced policy (auto-remediate)
resource "aws_fms_policy" "eu_west_2_shield_advanced_auto_remediate" {
  provider = aws.eu-west-2

  name                               = "shield_advanced_auto_remediate"
  delete_all_policy_resources        = true
  delete_unused_fm_managed_resources = false
  exclude_resource_tags              = false
  remediation_enabled                = true
  resource_type_list = [
    "AWS::EC2::EIP",
    "AWS::ElasticLoadBalancing::LoadBalancer",
    "AWS::ElasticLoadBalancingV2::LoadBalancer",
  ]

  include_map {
    account = try(toset(local.shield_advanced_auto_remediate.accounts), null)
    orgunit = try(toset(local.shield_advanced_auto_remediate.organizational_units), null)
  }

  resource_tags = {
    is-production = "false"
  }

  security_service_policy_data {
    type = "SHIELD_ADVANCED"
    managed_service_data = jsonencode({
      type = "SHIELD_ADVANCED"
    })
  }
}

# Shield Advanced policy (don't auto remediate)
resource "aws_fms_policy" "eu_west_2_shield_advanced_no_auto_remediate" {
  provider = aws.eu-west-2

  name                               = "shield_advanced_no_auto_remediate"
  delete_all_policy_resources        = true
  delete_unused_fm_managed_resources = false
  exclude_resource_tags              = false
  remediation_enabled                = false
  resource_type_list = [
    "AWS::EC2::EIP",
    "AWS::ElasticLoadBalancing::LoadBalancer",
    "AWS::ElasticLoadBalancingV2::LoadBalancer",
  ]

  include_map {
    account = try(toset(local.shield_advanced_no_auto_remediate.accounts), null)
    orgunit = try(toset(local.shield_advanced_no_auto_remediate.organizational_units), null)
  }

  resource_tags = {
    is-production = "false"
  }

  security_service_policy_data {
    type = "SHIELD_ADVANCED"
    managed_service_data = jsonencode({
      type = "SHIELD_ADVANCED"
    })
  }
}