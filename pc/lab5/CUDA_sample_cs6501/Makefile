NVCC = /usr/local/cuda/bin/nvcc

NVCC_FLAGS = -I/usr/local/cuda/include

# make dbg=1 tells nvcc to add debugging symbols to the binary
ifeq ($(dbg),1)
	NVCC_FLAGS += -g -O0
else
	NVCC_FLAGS += -O3
endif

# make emu=1 compiles the CUDA kernels for emulation
ifeq ($(emu),1)
	NVCC_FLAGS += -deviceemu
endif


vector_add: vector_add.cu
	$(NVCC) $(NVCC_FLAGS) vector_add.cu -o vector_add -lcuda


clean:
	rm -f *.o *~ vector_add
	