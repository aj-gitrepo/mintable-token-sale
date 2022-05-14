// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Context.sol";
import "./Roles.sol";

contract MinterRole is Context {
  using Roles for Roles.Role;

  event MinterAdded(address indexed account);
  event MinterRemoved(address indexed account);

  Roles.Role private _minters;

  constructor() {
    _addMinter(_msgSender());
  }

  modifier onlyMinter() {
    require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter Role");
    _;
  }

  function addMinter(address account) public onlyMinter {
    _addMinter(account);
  }

  function removeMinter() public {
    _removeMinter(_msgSender());
  }

  function isMinter(address account) public view returns(bool) {
    return _minters.has(account);
  }

  function _addMinter(address account) internal {
    _minters.add(account);
    emit MinterAdded(account);
  }

  function _removeMinter(address account) internal {
    _minters.remove(account);
    emit MinterRemoved(account);
  }
}
