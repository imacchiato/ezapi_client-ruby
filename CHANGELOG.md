# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] - 2019-02-01
### Fixed
- Do not send `account_no` if not needed

## [0.5.0] - 2017-09-06
### Added
- Set progname in log

## [0.4.0] - 2017-09-06
### Fixed
- Fix formatting of stdout and stderr during command execution

### Added
- Add logging capabilities

## [0.3.0] - 2016-10-11
### Added
- Include stdout in the exception raised when ExecCommand fails

## [0.2.1] - 2016-09-19
### Fixed
- updated jar for special characters fix

## [0.2.0] - 2016-08-25
### Changed
- Update `trans_date` to new required format (`2016-08-23 15:30:05 +0800`)
- Require `bank_code`, `branch_name`, `account_no` only if bank transaction

## [0.1.0] - 2016-08-22
### Added
- Initial working version
