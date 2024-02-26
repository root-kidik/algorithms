set(INCROOT ${PROJECT_SOURCE_DIR}/include)

set(SRC ${INCROOT}/searching/linear_search.hpp)

add_library(${PROJECT_NAME} INTERFACE ${SRC})

target_include_directories(${PROJECT_NAME} INTERFACE ${INCROOT})
