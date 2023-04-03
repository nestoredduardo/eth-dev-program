// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract Storage is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant WRITER_ROLE = keccak256("WRITER_ROLE");

    uint256 number;

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not an admin");
        _;
    }

    modifier onlyWriter() {
        require(hasRole(WRITER_ROLE, msg.sender), "Caller is not a writer");
        _;
    }

    modifier onlyDefaultAdmin() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "Caller is not a default admin"
        );
        _;
    }

    function grantWriterRole(address writer) public onlyAdmin {
        grantRole(WRITER_ROLE, writer);
    }

    function revokeWriterRole(address writer) public onlyAdmin {
        revokeRole(WRITER_ROLE, writer);
    }

    function grantAdminRole(address admin) public onlyDefaultAdmin {
        grantRole(ADMIN_ROLE, admin);
    }

    function revokeAdminRole(address admin) public onlyDefaultAdmin {
        revokeRole(ADMIN_ROLE, admin);
    }

    function store(uint256 num) public onlyWriter {
        number = num;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
}
