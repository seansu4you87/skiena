require_relative 'benchmark'

scale = TWOS.first 20

Analysis.dictionary_ll.run scale
Analysis.dictionary_bst.run scale # (1_000_000, 8 sec), (10_000_000, 7 min)
