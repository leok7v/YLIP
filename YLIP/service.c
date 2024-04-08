#include "service.h"
#include "assert.h"
#include "string.h"

errno_t foo(const uint8_t* input, int64_t input_bytes, uint8_t* output, int64_t *output_bytes) {
    assert(*output_bytes >= input_bytes);
    memcpy(output, input, (size_t)input_bytes);
    for (int32_t i = 0; i < input_bytes / 2; i++) {
        uint8_t b = output[i];
        output[i] = output[input_bytes - 1 - i];
        output[input_bytes - 1 - i] = b;
    }
    *output_bytes = input_bytes;
    return 0;
}
