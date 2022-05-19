file(REMOVE_RECURSE
  "libsalticidae.a"
  "libsalticidae.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/salticidae_static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
