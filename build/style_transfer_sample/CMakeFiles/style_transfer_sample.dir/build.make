# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

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
CMAKE_SOURCE_DIR = /opt/intel/openvino/deployment_tools/inference_engine/samples

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/penny2/build

# Include any dependencies generated for this target.
include style_transfer_sample/CMakeFiles/style_transfer_sample.dir/depend.make

# Include the progress variables for this target.
include style_transfer_sample/CMakeFiles/style_transfer_sample.dir/progress.make

# Include the compile flags for this target's objects.
include style_transfer_sample/CMakeFiles/style_transfer_sample.dir/flags.make

style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.o: style_transfer_sample/CMakeFiles/style_transfer_sample.dir/flags.make
style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.o: /opt/intel/openvino/deployment_tools/inference_engine/samples/style_transfer_sample/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/penny2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.o"
	cd /home/penny2/build/style_transfer_sample && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/style_transfer_sample.dir/main.cpp.o -c /opt/intel/openvino/deployment_tools/inference_engine/samples/style_transfer_sample/main.cpp

style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/style_transfer_sample.dir/main.cpp.i"
	cd /home/penny2/build/style_transfer_sample && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/intel/openvino/deployment_tools/inference_engine/samples/style_transfer_sample/main.cpp > CMakeFiles/style_transfer_sample.dir/main.cpp.i

style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/style_transfer_sample.dir/main.cpp.s"
	cd /home/penny2/build/style_transfer_sample && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/intel/openvino/deployment_tools/inference_engine/samples/style_transfer_sample/main.cpp -o CMakeFiles/style_transfer_sample.dir/main.cpp.s

# Object files for target style_transfer_sample
style_transfer_sample_OBJECTS = \
"CMakeFiles/style_transfer_sample.dir/main.cpp.o"

# External object files for target style_transfer_sample
style_transfer_sample_EXTERNAL_OBJECTS =

armv7l/Release/style_transfer_sample: style_transfer_sample/CMakeFiles/style_transfer_sample.dir/main.cpp.o
armv7l/Release/style_transfer_sample: style_transfer_sample/CMakeFiles/style_transfer_sample.dir/build.make
armv7l/Release/style_transfer_sample: armv7l/Release/lib/libformat_reader.so
armv7l/Release/style_transfer_sample: armv7l/Release/lib/libcpu_extension.so
armv7l/Release/style_transfer_sample: armv7l/Release/lib/libgflags_nothreads.a
armv7l/Release/style_transfer_sample: /opt/intel/openvino/deployment_tools/inference_engine/lib/armv7l/libinference_engine.so
armv7l/Release/style_transfer_sample: style_transfer_sample/CMakeFiles/style_transfer_sample.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/penny2/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../armv7l/Release/style_transfer_sample"
	cd /home/penny2/build/style_transfer_sample && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/style_transfer_sample.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
style_transfer_sample/CMakeFiles/style_transfer_sample.dir/build: armv7l/Release/style_transfer_sample

.PHONY : style_transfer_sample/CMakeFiles/style_transfer_sample.dir/build

style_transfer_sample/CMakeFiles/style_transfer_sample.dir/clean:
	cd /home/penny2/build/style_transfer_sample && $(CMAKE_COMMAND) -P CMakeFiles/style_transfer_sample.dir/cmake_clean.cmake
.PHONY : style_transfer_sample/CMakeFiles/style_transfer_sample.dir/clean

style_transfer_sample/CMakeFiles/style_transfer_sample.dir/depend:
	cd /home/penny2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/intel/openvino/deployment_tools/inference_engine/samples /opt/intel/openvino/deployment_tools/inference_engine/samples/style_transfer_sample /home/penny2/build /home/penny2/build/style_transfer_sample /home/penny2/build/style_transfer_sample/CMakeFiles/style_transfer_sample.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : style_transfer_sample/CMakeFiles/style_transfer_sample.dir/depend

