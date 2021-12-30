# Change Log

All notable changes to this project will be documented in this file.
This project *tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [0.6.0] - 2021-12-30
- [#4](https://github.com/tongueroo/s3-secure/pull/4) refactor move directly related cli classes to subfolder
- [#5](https://github.com/tongueroo/s3-secure/pull/5) add public access block support
- fix activesupport require

## [0.5.1]
- #3 add quiet option

## [0.5.0]
- add commands: access_logs, lifecycle, versioning, remediate_all
- s3 client is smarter and switches regions on a per-bucket basis

## [0.4.2]
- improve error message for Aws::STS::Errors::RegionDisabledException error

## [0.4.1]
- improve cli help

## [0.4.0]
-  #1 summary command

## [0.3.0]
- clean up policy_document method interface

## [0.2.0]
- encryption enable: add kms-key option

## [0.1.0]
- Initial release.
