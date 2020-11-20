# CppUTest library
# make build      -  
# make remake     -   
# make clean      -     
#


LIBRARY = CppUTest_Library
SOURCES_DIR = src/CppUTest
PLATFORM_SOURCES_DIR = src/Platforms/Gcc
OUTPUT_DIR = output
CC = g++
CFLAGS = -c\
            -D CPPUTEST_MEM_LEAK_DETECTION_DISABLED\
            -D CPPUTEST_USE_STD_C_LIB\
            -D CPPUTEST_STD_CPP_LIB_DISABLED

INCLUDE = -Iinclude


AR = ar
ARFLAGS = rcs

LIBRARY_OBJ =       CommandLineArguments.o\
                    CommandLineTestRunner.o\
                    JUnitTestOutput.o\
                    MemoryLeakDetector.o\
                    MemoryLeakWarningPlugin.o\
                    SimpleMutex.o\
                    SimpleString.o\
                    TeamCityTestOutput.o\
                    TestFailure.o\
                    TestFilter.o\
                    TestHarness_c.o\
                    TestMemoryAllocator.o\
                    TestOutput.o\
                    TestPlugin.o\
                    TestRegistry.o\
                    TestResult.o\
                    TestTestingFixture.o\
                    Utest.o
                    
PLATFORM_OBJ =      UtestPlatform.o

#-----------------------------------------------------------------
# add prefix to object paths
LIBRARY_OBJ_DIR = $(OUTPUT_DIR)/objects
_LIBRARY_OBJ = $(addprefix $(LIBRARY_OBJ_DIR)/, $(LIBRARY_OBJ))
_PLATFORM_OBJ = $(addprefix $(LIBRARY_OBJ_DIR)/, $(PLATFORM_OBJ))
#-----------------------------------------------------------------


.PHONY: build
build: $(OUTPUT_DIR)/$(LIBRARY).a

.PHONY: remake
remake: clean build


# archive
$(OUTPUT_DIR)/$(LIBRARY).a : $(_LIBRARY_OBJ) $(_PLATFORM_OBJ) makefile
	$(AR) $(ARFLAGS) $@ $(_LIBRARY_OBJ) $(_PLATFORM_OBJ)

# compile
$(OUTPUT_DIR)/objects/%.o : $(SOURCES_DIR)/%.cpp makefile
	$(CC) $(CFLAGS) $(INCLUDE) $< -o $@

$(OUTPUT_DIR)/objects/%.o : $(PLATFORM_SOURCES_DIR)/%.cpp makefile
	$(CC) $(CFLAGS) $(INCLUDE) $< -o $@

.PHONY: clean
clean:
	rm $(OUTPUT_DIR)/objects/*.* -f
	rm $(OUTPUT_DIR)/listings/*.* -f
	rm $(OUTPUT_DIR)/*.* -f

