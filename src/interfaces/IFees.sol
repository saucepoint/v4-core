// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Currency} from "../types/Currency.sol";
import {IProtocolFeeController} from "./IProtocolFeeController.sol";

interface IFees {
    /// @notice Thrown when the protocol fee denominator is less than 4. Also thrown when the static or dynamic fee on a pool is exceeds 100%.
    error FeeTooLarge();
    /// @notice Thrown when not enough gas is provided to look up the protocol fee
    error ProtocolFeeCannotBeFetched();
    /// @notice Thrown when the call to fetch the protocol fee reverts or returns invalid data.
    error ProtocolFeeControllerCallFailedOrInvalidResult();
    /// @notice Thrown when a pool does not have a dynamic fee.
    error FeeNotDynamic();

    event ProtocolFeeControllerUpdated(address protocolFeeController);

    function protocolFeeController() external view returns (IProtocolFeeController);

    /// @notice Returns the minimum denominator for the protocol fee, which restricts it to a maximum of 25%
    function MIN_PROTOCOL_FEE_DENOMINATOR() external view returns (uint8);

    /// @notice Given a currency address, returns the protocol fees accrued in that currency
    function protocolFeesAccrued(Currency) external view returns (uint256);

    /// @notice Set the protocol's fee controller
    function setProtocolFeeController(IProtocolFeeController controller) external;

    function collectProtocolFees(address recipient, Currency currency, uint256 amount)
        external
        returns (uint256 amountCollected);
}
