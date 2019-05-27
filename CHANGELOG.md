# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Fixed
- No longer escape JSON values

## [1.1.0] - 2019-05-27
### Added
- Response `#raw_body` to access the raw, unparsed body directly

### Fixed
- BaseResponse #code and #message are nil if #response_body is nil

## [1.0.3] - 2019-05-27
### Fixed
- EZAPI server couldn't parse escaped JSON; escape values instead of whole JSON instead
- Response `#success` is false if response is not valid JSON

## [1.0.2] - 2019-05-14
### Fixed
- Shell command to java blows up when sender/recipient name or address includes `'`

## [1.0.1] - 2019-02-01
### Fixed
- Fixed list of transaction types that need account numbers

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
