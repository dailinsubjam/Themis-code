# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/Ted-original/libhotstuff

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/Ted-original/libhotstuff

# Include any dependencies generated for this target.
include salticidae/CMakeFiles/salticidae_shared.dir/depend.make

# Include the progress variables for this target.
include salticidae/CMakeFiles/salticidae_shared.dir/progress.make

# Include the compile flags for this target's objects.
include salticidae/CMakeFiles/salticidae_shared.dir/flags.make

# Object files for target salticidae_shared
salticidae_shared_OBJECTS =

# External object files for target salticidae_shared
salticidae_shared_EXTERNAL_OBJECTS = \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/type.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/util.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/event.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/crypto.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/stream.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/msg.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/netaddr.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/conn.cpp.o" \
"/home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae.dir/src/network.cpp.o"

salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/type.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/util.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/event.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/crypto.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/stream.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/msg.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/netaddr.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/conn.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae.dir/src/network.cpp.o
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae_shared.dir/build.make
salticidae/libsalticidae.so: salticidae/CMakeFiles/salticidae_shared.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/Ted-original/libhotstuff/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Linking CXX shared library libsalticidae.so"
	cd /home/ubuntu/Ted-original/libhotstuff/salticidae && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/salticidae_shared.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
salticidae/CMakeFiles/salticidae_shared.dir/build: salticidae/libsalticidae.so

.PHONY : salticidae/CMakeFiles/salticidae_shared.dir/build

salticidae/CMakeFiles/salticidae_shared.dir/clean:
	cd /home/ubuntu/Ted-original/libhotstuff/salticidae && $(CMAKE_COMMAND) -P CMakeFiles/salticidae_shared.dir/cmake_clean.cmake
.PHONY : salticidae/CMakeFiles/salticidae_shared.dir/clean

salticidae/CMakeFiles/salticidae_shared.dir/depend:
	cd /home/ubuntu/Ted-original/libhotstuff && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/Ted-original/libhotstuff /home/ubuntu/Ted-original/libhotstuff/salticidae /home/ubuntu/Ted-original/libhotstuff /home/ubuntu/Ted-original/libhotstuff/salticidae /home/ubuntu/Ted-original/libhotstuff/salticidae/CMakeFiles/salticidae_shared.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : salticidae/CMakeFiles/salticidae_shared.dir/depend

