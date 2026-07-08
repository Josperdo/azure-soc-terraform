## Changelog

### v2.1.0 (2026-07-08)
- Added `terraform.tfvars.payg.example` for `environments/azure` — a pay-as-you-go profile (Standard Bastion SKU, 90-day log retention) alongside the existing free-trial-oriented example
- Exposed `bastion_sku` as an `environments/azure` variable (was hardcoded to the module default)
- Fixed `modules/azure/bastion` to explicitly set `tunneling_enabled` / `ip_connect_enabled` on Standard/Premium SKU — selecting the SKU alone doesn't turn on native-client support, found via live deploy testing of the PAYG profile
- Documented the Azure trial vs. pay-as-you-go tfvars profiles and their cost delta in `README.md`
- Live-verified end-to-end: Azure PAYG profile deploys, native client Bastion SSH (`az network bastion ssh`) connects, hardening and Sentinel log ingestion confirmed
- AWS pay-as-you-go profile is in progress, kept local pending testing

### v2.0.0 (2026-03-14)
- Added AWS multi-cloud support alongside existing Azure deployment
- New `modules/aws/` with network, compute, bastion, and monitoring submodules
- New `environments/aws/` root module wired to all AWS modules
- Reorganized Azure modules under `modules/azure/` and `environments/azure/` for consistency
- Added `Makefile` for single-command deploy to either cloud (`make azure` / `make aws`)
- Updated CI/CD pipeline to validate and tfsec-scan both Azure and AWS configurations
- Added GuardDuty, CloudWatch, and SNS alerting in AWS monitoring module
- Added cloud-init hardening for AWS EC2 instances (mirrors Azure VM hardening)
- Added `terraform.tfvars.example` for AWS environment
- Added screenshots: security alerts, syslog attack events, SOC workbook

### v1.0.0 (2026-02-24)
- Initial release
- Azure Sentinel deployment
- Log Analytics workspace
- Basic detection rules
- Conditional access policies