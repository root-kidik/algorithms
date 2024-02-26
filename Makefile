CMAKE_COMMON_FLAGS ?= -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
CMAKE_DEBUG_FLAGS ?= 
CMAKE_RELEASE_FLAGS ?=
CLANG_FORMAT ?= clang-format

CMAKE_DEBUG_FLAGS += -DCMAKE_BUILD_TYPE=Debug $(CMAKE_COMMON_FLAGS)
CMAKE_RELEASE_FLAGS += -DCMAKE_BUILD_TYPE=Release $(CMAKE_COMMON_FLAGS)

# Debug cmake configuration
build_debug/Makefile: 
	cmake -B build_debug $(CMAKE_DEBUG_FLAGS)

# Release cmake configuration
build_release/Makefile: 
	cmake -B build_release $(CMAKE_RELEASE_FLAGS)

# Symlink to compile_commands
.PHONY: symlink-debug symlink-release
symlink-debug symlink-release: symlink-%: build_%/Makefile
	rm -rf compile_commands.json
	ln -s build_$*/compile_commands.json compile_commands.json

# Run cmake
.PHONY: cmake-debug cmake-release
cmake-debug cmake-release: cmake-%: symlink-%

# Build 
.PHONY: build-debug build-release
build-debug build-release: build-%: cmake-%
	cmake --build build_$* -j8 --target algorithms 

# Run unittests 
.PHONY: test-debug test-release
test-debug test-release: test-%: build-%
	cmake --build build_$* -j8 --target algorithms_unittest  
	./build_$*/bin/algorithms_unittest 

# Format the sources
.PHONY: format
format:
	find src tests -name '*pp' -type f | xargs $(CLANG_FORMAT) -i

# Clean all builds
.PHONY: dist-clean
dist-clean:
	rm -rf build_*
