require 'benchmark'

require_relative 'analysis'
require_relative '../lib/abacus'
require_relative '../lib/lego'

TENS = [
  10,
  100,
  1_000,
  10_000,
  100_000,
  1_000_000,
  10_000_000,
  100_000_000,
]

TWOS = [
  2, 4, 8, 16, 32, 64, 128, 256, 512,
  1_024, 2_048, 4_096, 8_192, 16_384,
  32_768, 65_536, 131_072, 262_144, 524_288,
  1_048_576, 2_097_152, 4_194_304, 8_388_608,
  16_777_216, 33_554_432, 67_108_864,
  # 134_217_728,
  # 268_435_456,
]

def scale(n, sizes)
  sizes.map { |s| n * s }
end

# TODO(yu): compare specific methods on different Analysis objects
# method_name = "Insert"
# ll.run(tens, method_name)
# bst.run(tens, method_name)

