resource "powerplatform_environment" "devEnv" {
  display_name     = var.env_name
  location         = var.env_location
  environment_type = var.env_type
  #billing_policy_id = "<payg billing policy>"
  dataverse = {
    language_code     = "1033"
    currency_code     = "USD"
    security_group_id = "00000000-0000-0000-0000-000000000000"
  }
}


resource "powerplatform_environment_settings" "devSettings" {
  environment_id = powerplatform_environment.devEnv.id
  
  audit_and_logs = {
    plugin_trace_log_setting = "Exception"
    audit_settings = {
      is_audit_enabled             = true
      is_user_access_audit_enabled = true
      is_read_audit_enabled        = true
    }
  }
  product = {
    behavior_settings = {
      show_dashboard_cards_in_expanded_state = true
    }
    features = {
      power_apps_component_framework_for_canvas_apps = true
    }
  }
}