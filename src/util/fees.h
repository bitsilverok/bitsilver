// Copyright (c) 2009-2010 Satoshi Nakamoto
// Copyright (c) 2009-2019 The BitSilver Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
#ifndef BITSILVER_UTIL_FEES_H
#define BITSILVER_UTIL_FEES_H

#include <string>

enum class FeeEstimateMode;
enum class FeeReason;

bool FeeModeFromString(const std::string& mode_string, FeeEstimateMode& fee_estimate_mode);
std::string StringForFeeReason(FeeReason reason);

#endif // BITSILVER_UTIL_FEES_H
