#ifndef service_h
#define service_h

#include <stdint.h>
#include <errno.h>

errno_t foo(const uint8_t* input, int64_t input_bytes, uint8_t* output, int64_t *output_bytes);

#endif /* service_h */
