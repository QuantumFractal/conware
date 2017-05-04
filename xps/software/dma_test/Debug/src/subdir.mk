################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/axi_dma_ftw.c \
../src/dma_test.c \
../src/platform.c 

LD_SRCS += \
../src/lscript.ld 

OBJS += \
./src/axi_dma_ftw.o \
./src/dma_test.o \
./src/platform.o 

C_DEPS += \
./src/axi_dma_ftw.d \
./src/dma_test.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM gcc compiler'
	arm-xilinx-eabi-gcc -Wall -O0 -g3 -c -fmessage-length=0 -I../../conware_bsp/ps7_cortexa9_0/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


