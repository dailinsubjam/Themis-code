file(REMOVE_RECURSE
  "libhotstuff.a"
  "libhotstuff.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/hotstuff_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
