// Copyright (c) 2011-2014 The Fastbitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef FASTBITCOIN_QT_FASTBITCOINADDRESSVALIDATOR_H
#define FASTBITCOIN_QT_FASTBITCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class FastbitcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit FastbitcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Fastbitcoin address widget validator, checks for a valid fastbitcoin address.
 */
class FastbitcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit FastbitcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // FASTBITCOIN_QT_FASTBITCOINADDRESSVALIDATOR_H
