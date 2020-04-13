// Copyright (c) 2011-2014 The BitSilver Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITSILVER_QT_BITSILVERADDRESSVALIDATOR_H
#define BITSILVER_QT_BITSILVERADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitSilverAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitSilverAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** BitSilver address widget validator, checks for a valid bitsilver address.
 */
class BitSilverAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitSilverAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BITSILVER_QT_BITSILVERADDRESSVALIDATOR_H
