package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVPCModule(t *testing.T) {
	t.Parallel()

	awsRegion := "us-west-2"
	uniqueID := random.UniqueId()

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
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	igwID := terraform.Output(t, terraformOptions, "internet_gateway_id")
	publicRTID := terraform.Output(t, terraformOptions, "public_route_table_id")

	assert.True(t, aws.IsVpcAvailable(t, vpcID, awsRegion))
	assert.True(t, aws.IsInternetGatewayAvailable(t, igwID, awsRegion))
	assert.True(t, aws.IsRouteTableAvailable(t, publicRTID, awsRegion))
}
