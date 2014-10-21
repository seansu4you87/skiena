require_relative 'benchmark'

Analysis.dictionary_ll.run tens
Analysis.dictionary_bst.run tens # (1_000_000, 8 sec), (10_000_000, 7 min)
