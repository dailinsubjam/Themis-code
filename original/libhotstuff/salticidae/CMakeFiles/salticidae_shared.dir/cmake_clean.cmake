file(REMOVE_RECURSE
  "libsalticidae.pdb"
  "libsalticidae.so"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/salticidae_shared.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
