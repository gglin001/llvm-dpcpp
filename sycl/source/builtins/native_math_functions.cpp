//==------------------- native_math_functions.cpp --------------------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <sycl/detail/builtins/builtins.hpp>

#include "host_helper_macros.hpp"

#include <cmath>

// ############################################################################

// fix error for ubuntu-22.04 toolchain
// code from musl-libc

#include <math.h>
#include <stdint.h>

extern "C" {

float __frexpf(float x, int *e) {
  union {
    float f;
    uint32_t i;
  } y = {x};
  int ee = y.i >> 23 & 0xff;

  if (!ee) {
    if (x) {
      x = __frexpf(x * 0x1p64, e);
      *e -= 64;
    } else
      *e = 0;
    return x;
  } else if (ee == 0xff) {
    return x;
  }

  *e = ee - 0x7e;
  y.i &= 0x807ffffful;
  y.i |= 0x3f000000ul;
  return y.f;
}

double __frexp(double x, int *e) {
  union {
    double d;
    uint64_t i;
  } y = {x};
  int ee = y.i >> 52 & 0x7ff;

  if (!ee) {
    if (x) {
      x = __frexp(x * 0x1p64, e);
      *e -= 64;
    } else
      *e = 0;
    return x;
  } else if (ee == 0x7ff) {
    return x;
  }

  *e = ee - 0x3fe;
  y.i &= 0x800fffffffffffffull;
  y.i |= 0x3fe0000000000000ull;
  return y.d;
}

float __ldexpf(float x, int n) { return scalbnf(x, n); }

double __scalbn(double x, int n) {
  union {
    double f;
    uint64_t i;
  } u;
  double_t y = x;

  if (n > 1023) {
    y *= 0x1p1023;
    n -= 1023;
    if (n > 1023) {
      y *= 0x1p1023;
      n -= 1023;
      if (n > 1023)
        n = 1023;
    }
  } else if (n < -1022) {
    /* make sure final n < -53 to avoid double
       rounding in the subnormal range */
    y *= 0x1p-1022 * 0x1p53;
    n += 1022 - 53;
    if (n < -1022) {
      y *= 0x1p-1022 * 0x1p53;
      n += 1022 - 53;
      if (n < -1022)
        n = -1022;
    }
  }
  u.i = (uint64_t)(0x3ff + n) << 52;
  x = y * u.f;
  return x;
}

double __ldexp(double x, int n) { return scalbn(x, n); }

float __scalbnf(float x, int n) {
  union {
    float f;
    uint32_t i;
  } u;
  float_t y = x;

  if (n > 127) {
    y *= 0x1p127f;
    n -= 127;
    if (n > 127) {
      y *= 0x1p127f;
      n -= 127;
      if (n > 127)
        n = 127;
    }
  } else if (n < -126) {
    y *= 0x1p-126f * 0x1p24f;
    n += 126 - 24;
    if (n < -126) {
      y *= 0x1p-126f * 0x1p24f;
      n += 126 - 24;
      if (n < -126)
        n = -126;
    }
  }
  u.i = (uint32_t)(0x7f + n) << 23;
  x = y * u.f;
  return x;
}
}

// ############################################################################

namespace sycl {
inline namespace _V1 {
namespace native {
#define BUILTIN_NATIVE_CUSTOM(NUM_ARGS, NAME, IMPL)                            \
  HOST_IMPL(NAME, IMPL)                                                        \
  EXPORT_SCALAR_AND_VEC_1_16_NS(NUM_ARGS, NAME, native, float)

#define BUILTIN_NATIVE(NUM_ARGS, NAME)                                         \
  BUILTIN_NATIVE_CUSTOM(NUM_ARGS, NAME, std::NAME)

BUILTIN_NATIVE(ONE_ARG, cos)
BUILTIN_NATIVE_CUSTOM(TWO_ARGS, divide, [](auto x, auto y) { return x / y; })
BUILTIN_NATIVE(ONE_ARG, exp)
BUILTIN_NATIVE(ONE_ARG, exp2)
BUILTIN_NATIVE_CUSTOM(ONE_ARG, exp10, [](auto x) { return std::pow(10.0f, x); })
BUILTIN_NATIVE(ONE_ARG, log)
BUILTIN_NATIVE(ONE_ARG, log2)
BUILTIN_NATIVE(ONE_ARG, log10)
BUILTIN_NATIVE_CUSTOM(TWO_ARGS, powr, [](auto x, auto y) {
  return (x >= 0 ? std::pow(x, y) : x);
})
BUILTIN_NATIVE_CUSTOM(ONE_ARG, recip, [](auto x) { return 1.0f / x; })
BUILTIN_NATIVE_CUSTOM(ONE_ARG, rsqrt,
                      [](auto x) { return 1.0f / std::sqrt(x); })
BUILTIN_NATIVE(ONE_ARG, sin)
BUILTIN_NATIVE(ONE_ARG, sqrt)
BUILTIN_NATIVE(ONE_ARG, tan)
} // namespace native
} // namespace _V1
} // namespace sycl
