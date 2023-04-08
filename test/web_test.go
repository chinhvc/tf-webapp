package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestWebAppModule(t *testing.T) {
	// Set up Terraform options.
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/basic_usage",
		Vars: map[string]interface{}{
			"key_pair_name": "your-key-pair-name",
			"db_username":   "your-db-username",
			"db_password":   "your-db-password",
		},
	}

	// Defer the destroy function to clean up resources after the test is complete.
	defer terraform.Destroy(t, terraformOptions)

	// Initialize and apply the Terraform configuration.
	terraform.InitAndApply(t, terraformOptions)

	// Retrieve output values from the Terraform configuration.
	webAppPublicIP := terraform.Output(t, terraformOptions, "web_app_public_ip")
	dbInstanceEndpoint := terraform.Output(t, terraformOptions, "db_instance_endpoint")

	// Perform assertions based on the output values.
	aws.AssertHttpStatusCodeIs(t, webAppPublicIP, "index.html", 80, 200)
	// Add more assertions for your specific use case.

}
