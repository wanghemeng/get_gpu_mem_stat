#include <stdio.h>
#include <nvml.h>

int main() {
    nvmlReturn_t result;
    nvmlDevice_t device;

    // Initialize NVML library
    result = nvmlInit();
    if (result != NVML_SUCCESS) {
        printf("Failed to initialize NVML library: %s\n", nvmlErrorString(result));
        return 1;
    }

    // Get the first available GPU device
    result = nvmlDeviceGetHandleByIndex(0, &device);
    if (result != NVML_SUCCESS) {
        printf("Failed to get GPU device handle: %s\n", nvmlErrorString(result));
        nvmlShutdown();
        return 1;
    }

    nvmlMemory_t memory;

    // Continuously monitor GPU memory usage
    unsigned int maxMemoryUsageMb = 0;
    while (1) {
        // Get the current memory usage in bytes
        result = nvmlDeviceGetMemoryInfo(device, &memory);
        if (result != NVML_SUCCESS) {
            printf("Failed to get memory info: %s\n", nvmlErrorString(result));
            nvmlShutdown();
            return 1;
        }

        // Convert memory usage to megabytes
        unsigned int memoryUsageMb = memory.used / 1024 / 1024;

        // Update max memory usage if necessary
        if (memoryUsageMb > maxMemoryUsageMb) {
            maxMemoryUsageMb = memoryUsageMb;
        }

        // Print the memory usage in megabytes
        printf("Peak GPU Memory Usage: %u MB\n", maxMemoryUsageMb);

    }

    // Shutdown NVML library
    nvmlShutdown();

    return 0;
}