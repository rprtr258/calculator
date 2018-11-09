#ifndef BIGINTEGER_H
#define BIGINTEGER_H

#include <deque>
#include <string>
#include <iostream>

using namespace std;

class BigNumber {
public:
    enum { BASE = 1000*1000*1000 };
    BigNumber(int = 0);
    BigNumber operator+(const BigNumber &) const;
    BigNumber operator-(const BigNumber &) const;
    BigNumber operator/(const BigNumber &) const;
    BigNumber operator*(const BigNumber &) const;
    BigNumber operator%(const BigNumber &) const;
    bool operator<(const BigNumber &) const;
    bool operator!=(const int &) const;
    bool isZero() const;
    void print(std::ostream &) const;
    std::deque<unsigned long long> data_;
private:
    unsigned findDiv(const BigNumber &, const BigNumber &) const;
};

std::ostream &operator<<(std::ostream &s, const BigNumber &n);

#endif
