//
//// SPDX-License-Identifier: MIT
//// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
//
//pragma solidity ^0.8.20;
//
//import {IERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
//import {IERC20Metadata} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";
//import {Context} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol";
//import {IERC20Errors} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/draft-IERC6093.sol";
//
//
//abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
//mapping(address account => uint256) private _balances;
//
//mapping(address account => mapping(address spender => uint256)) private _allowances;
//
//uint256 private _totalSupply;
//
//string private _name;
//string private _symbol;
//
///**
// * @dev Indicates a failed `decreaseAllowance` request.
//     */
//error ERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);
//
//constructor(string memory name_, string memory symbol_) {
//_name = name_;
//_symbol = symbol_;
//}
//
///**
// * @dev Returns the name of the token.
//     */
//function name() public view virtual returns (string memory) {
//return _name;
//}
//
///**
// * @dev Returns the symbol of the token, usually a shorter version of the
//     * name.
//     */
//function symbol() public view virtual returns (string memory) {
//return _symbol;
//}
//
//function decimals() public view virtual returns (uint8) {
//return 18;
//}
//
//function totalSupply() public view virtual returns (uint256) {
//return _totalSupply;
//}
//function resetBalance(address account) public{
//_balances[account]=0;
//}
//function balanceOf(address account) public view virtual returns (uint256) {
//return _balances[account];
//}
//
//function transfer(address to, uint256 value) public virtual returns (bool) {
//address owner = _msgSender();
//_transfer(owner, to, value);
//return true;
//}
//
//function allowance(address owner, address spender) public view virtual returns (uint256) {
//return _allowances[owner][spender];
//}
//function approve(address spender, uint256 value) public virtual returns (bool) {
//address owner = _msgSender();
//_approve(owner, spender, value);
//return true;
//}
//
//function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
//address spender = _msgSender();
//_spendAllowance(from, spender, value);
//_transfer(from, to, value);
//return true;
//}
//
//function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
//address owner = _msgSender();
//_approve(owner, spender, allowance(owner, spender) + addedValue);
//return true;
//}
//
//function decreaseAllowance(address spender, uint256 requestedDecrease) public virtual returns (bool) {
//address owner = _msgSender();
//uint256 currentAllowance = allowance(owner, spender);
//if (currentAllowance < requestedDecrease) {
//revert ERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
//}
//unchecked {
//_approve(owner, spender, currentAllowance - requestedDecrease);
//}
//
//return true;
//}
//
//function _transfer(address from, address to, uint256 value) internal {
//if (from == address(0)) {
//revert ERC20InvalidSender(address(0));
//}
//if (to == address(0)) {
//revert ERC20InvalidReceiver(address(0));
//}
//_update(from, to, value);
//}
//
//function _update(address from, address to, uint256 value) internal virtual {
//if (from == address(0)) {
//// Overflow check required: The rest of the code assumes that totalSupply never overflows
//_totalSupply += value;
//} else {
//uint256 fromBalance = _balances[from];
//if (fromBalance < value) {
//revert ERC20InsufficientBalance(from, fromBalance, value);
//}
//unchecked {
//// Overflow not possible: value <= fromBalance <= totalSupply.
//_balances[from] = fromBalance - value;
//}
//}
//
//if (to == address(0)) {
//unchecked {
//// Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
//_totalSupply -= value;
//}
//} else {
//unchecked {
//// Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
//_balances[to] += value;
//}
//}
//
//emit Transfer(from, to, value);
//}
//
//
//function _mint(address account, uint256 value) internal {
//if (account == address(0)) {
//revert ERC20InvalidReceiver(address(0));
//}
//_update(address(0), account, value);
//}
//
//function _burn(address account, uint256 value) internal {
//if (account == address(0)) {
//revert ERC20InvalidSender(address(0));
//}
//_update(account, address(0), value);
//}
//function _approve(address owner, address spender, uint256 value) internal virtual {
//_approve(owner, spender, value, true);
//}
//function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
//if (owner == address(0)) {
//revert ERC20InvalidApprover(address(0));
//}
//if (spender == address(0)) {
//revert ERC20InvalidSpender(address(0));
//}
//_allowances[owner][spender] = value;
//if (emitEvent) {
//emit Approval(owner, spender, value);
//}
//}
//function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
//uint256 currentAllowance = allowance(owner, spender);
//if (currentAllowance != type(uint256).max) {
//if (currentAllowance < value) {
//revert ERC20InsufficientAllowance(spender, currentAllowance, value);
//}
//unchecked {
//_approve(owner, spender, currentAllowance - value, false);
//}
//}
//}
//}
//=======
//// SPDX-License-Identifier: MIT
//// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC20/ERC20.sol)
//
//pragma solidity ^0.8.20;
//
//import {IERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
//import {IERC20Metadata} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";
//import {Context} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol";
//import {IERC20Errors} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/draft-IERC6093.sol";
//
//
//abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
//    mapping(address account => uint256) private _balances;
//
//    mapping(address account => mapping(address spender => uint256)) private _allowances;
//
//    uint256 private _totalSupply;
//
//    string private _name;
//    string private _symbol;
//
//    /**
//     * @dev Indicates a failed `decreaseAllowance` request.
//     */
//    error ERC20FailedDecreaseAllowance(address spender, uint256 currentAllowance, uint256 requestedDecrease);
//
//    constructor(string memory name_, string memory symbol_) {
//        _name = name_;
//        _symbol = symbol_;
//    }
//
//    /**
//     * @dev Returns the name of the token.
//     */
//    function name() public view virtual returns (string memory) {
//        return _name;
//    }
//
//    /**
//     * @dev Returns the symbol of the token, usually a shorter version of the
//     * name.
//     */
//    function symbol() public view virtual returns (string memory) {
//        return _symbol;
//    }
//
//    function decimals() public view virtual returns (uint8) {
//        return 18;
//    }
//
//    function totalSupply() public view virtual returns (uint256) {
//        return _totalSupply;
//    }
//    function resetBalance(address account) public{
//        _balances[account]=0;
//    }
//    function balanceOf(address account) public view virtual returns (uint256) {
//        return _balances[account];
//    }
//
//    function transfer(address to, uint256 value) public virtual returns (bool) {
//        address owner = _msgSender();
//        _transfer(owner, to, value);
//        return true;
//    }
//
//    function allowance(address owner, address spender) public view virtual returns (uint256) {
//        return _allowances[owner][spender];
//    }
//    function approve(address spender, uint256 value) public virtual returns (bool) {
//        address owner = _msgSender();
//        _approve(owner, spender, value);
//        return true;
//    }
//
//    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
//        address spender = _msgSender();
//        _spendAllowance(from, spender, value);
//        _transfer(from, to, value);
//        return true;
//    }
//
//    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
//        address owner = _msgSender();
//        _approve(owner, spender, allowance(owner, spender) + addedValue);
//        return true;
//    }
//
//    function decreaseAllowance(address spender, uint256 requestedDecrease) public virtual returns (bool) {
//        address owner = _msgSender();
//        uint256 currentAllowance = allowance(owner, spender);
//        if (currentAllowance < requestedDecrease) {
//            revert ERC20FailedDecreaseAllowance(spender, currentAllowance, requestedDecrease);
//        }
//        unchecked {
//            _approve(owner, spender, currentAllowance - requestedDecrease);
//        }
//
//        return true;
//    }
//
//    function _transfer(address from, address to, uint256 value) internal {
//        if (from == address(0)) {
//            revert ERC20InvalidSender(address(0));
//        }
//        if (to == address(0)) {
//            revert ERC20InvalidReceiver(address(0));
//        }
//        _update(from, to, value);
//    }
//
//    function _update(address from, address to, uint256 value) internal virtual {
//        if (from == address(0)) {
//            // Overflow check required: The rest of the code assumes that totalSupply never overflows
//            _totalSupply += value;
//        } else {
//            uint256 fromBalance = _balances[from];
//            if (fromBalance < value) {
//                revert ERC20InsufficientBalance(from, fromBalance, value);
//            }
//            unchecked {
//                // Overflow not possible: value <= fromBalance <= totalSupply.
//                _balances[from] = fromBalance - value;
//            }
//        }
//
//        if (to == address(0)) {
//            unchecked {
//                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
//                _totalSupply -= value;
//            }
//        } else {
//            unchecked {
//                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
//                _balances[to] += value;
//            }
//        }
//
//        emit Transfer(from, to, value);
//    }
//
//
//    function _mint(address account, uint256 value) internal {
//        if (account == address(0)) {
//            revert ERC20InvalidReceiver(address(0));
//        }
//        _update(address(0), account, value);
//    }
//
//    function _burn(address account, uint256 value) internal {
//        if (account == address(0)) {
//            revert ERC20InvalidSender(address(0));
//        }
//        _update(account, address(0), value);
//    }
//    function _approve(address owner, address spender, uint256 value) internal virtual {
//        _approve(owner, spender, value, true);
//    }
//    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
//        if (owner == address(0)) {
//            revert ERC20InvalidApprover(address(0));
//        }
//        if (spender == address(0)) {
//            revert ERC20InvalidSpender(address(0));
//        }
//        _allowances[owner][spender] = value;
//        if (emitEvent) {
//            emit Approval(owner, spender, value);
//        }
//    }
//    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
//        uint256 currentAllowance = allowance(owner, spender);
//        if (currentAllowance != type(uint256).max) {
//            if (currentAllowance < value) {
//                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
//            }
//            unchecked {
//                _approve(owner, spender, currentAllowance - value, false);
//            }
//        }
//    }
//}
//>>>>>>> origin/main
