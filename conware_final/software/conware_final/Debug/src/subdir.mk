################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/axi_dma_ftw.c \
../src/conware_test.c \
../src/conway.c \
../src/conway_final.c \
../src/conway_launch.c \
../src/platform.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/axi_dma_ftw.o \
./src/conware_test.o \
./src/conway.o \
./src/conway_final.o \
./src/conway_launch.o \
./src/platform.o 

C_DEPS += \
./src/axi_dma_ftw.d \
./src/conware_test.d \
./src/conway.d \
./src/conway_final.d \
./src/conway_launch.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../standalone_bsp_0/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


