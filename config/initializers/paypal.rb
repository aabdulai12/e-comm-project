require 'paypal-sdk-rest'


# Configure PayPal Environment
environment = PayPal::SandboxEnvironment.new(
  "AesRa5c2gV-k8rX7EY3_ukrXPw8iQJJSLJoPgz1VHCo1hZug0TYeUeQOuctzqF4SqfITtFqGXLfPdoGE",     # Replace with your PayPal Client ID
  "EMP-Ax2JZBwd4IjKuhyoZiul5ofOFNmnJm0cfPLrTdVLmr0iRROOL978FBo-DfZvaCfVWEiTa5bN5boE"  # Replace with your PayPal Client Secret
)

# Create PayPal Client
PayPalClient = PayPal::PayPalHttpClient.new(environment)