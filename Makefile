NVCC = nvcc

TARGET = main

SOURCE = main.cu

LIBS = -lnvidia-ml

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(NVCC) $< -o $@ $(LIBS)

clean:
	rm -f $(TARGET)