set(TEST_NAME ${PROJECT_NAME}_unittest)

set(SRCROOT ${PROJECT_SOURCE_DIR}/tests)

set(SRC ${SRCROOT}/searching_test.cpp)

find_package(GTest REQUIRED)

add_executable(${TEST_NAME} ${SRC})
target_link_libraries(${TEST_NAME} GTest::gtest_main ${PROJECT_NAME})

include(GoogleTest)
gtest_discover_tests(${TEST_NAME})
