package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVPCModule(t *testing.T) {
	t.Parallel()

	awsRegion := "us-west-2"

	terraformOptions := &terraform.Options{
		TerraformDir: "../vpc",

		Vars: map[string]interface{}{
			// Add any required variables here
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	// Add your assertions here
}
