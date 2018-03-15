#define CL_USE_DEPRECATED_OPENCL_1_2_APIS
#include <stdio.h>
#include <stdlib.h>
#include <CL/cl.h>


const char* programSource = 
"__Kernel                             \n"
"void vecadd(__global int *A          \n"
"            __global int *B          \n"
"            __global int *C          \n"
"{                                    \n"
"	int idx = get_global_id(0);       \n"
"	C[idx] = A[idx] + B[idx];         \n"
"}                                    \n";   

int main() {
cl_int status; 				//variable para verificar errores
cl_uint numPlatforms = 0;
status = clGetPlatformIDs(0,NULL,&numPlatforms);
//platforms
cl_platform_id *platforms = NULL;
platforms = (cl_platform_id*)malloc(numPlatforms*sizeof(cl_platform_id));
status = clGetPlatformIDs(numPlatforms,platforms,NULL);
// Divice
cl_uint numDevices = 0;
status = clGetDeviceIDs(platforms[0], CL_DEVICE_TYPE_ALL, 0, NULL, &numDevices);
cl_device_id * devices;
devices = (cl_device_id*)malloc(numDevices*sizeof(cl_device_id));
status = clGetDeviceIDs(platforms[0], CL_DEVICE_TYPE_ALL,numDevices,devices,NULL);
//context
cl_context context;
context = clCreateContext(NULL, numDevices, devices, NULL, NULL, &status);
// Command Queue
cl_command_queue cmdQueue;
cmdQueue = clCreateCommandQueue(context, devices[0],0,&status);
//Host data
int *A = NULL;
int *B = NULL;
int *C = NULL;

const int elements = 2048;
size_t datasize = sizeof(int)*elements;

A = (int*)malloc(datasize);
B = (int*)malloc(datasize);
C = (int*)malloc(datasize);

for(int i = 0; i < elements; i++) {
   A[i] = i;
   B[i] = i;
}

// create buffers
cl_mem bufA;
bufA = clCreateBuffer(context, CL_MEM_READ_ONLY, datasize, NULL, &status);
cl_mem bufB;
bufB = clCreateBuffer(context, CL_MEM_READ_ONLY, datasize, NULL, &status);
cl_mem bufC;
bufC = clCreateBuffer(context, CL_MEM_READ_ONLY, datasize, NULL, &status);
//write input array to the device

status = clEnqueueWriteBuffer(cmdQueue, bufA, CL_FALSE, 0, datasize, A, 0, NULL, NULL);
status = clEnqueueWriteBuffer(cmdQueue, bufB, CL_FALSE, 0, datasize, B, 0, NULL, NULL);

// Create a program with source code
  cl_program program = clCreateProgramWithSource(context,1,(const char **)&programSource,NULL,&status);
    //build (compile) the program for the device
   status = clBuildProgram(program, numDevices, devices, NULL, NULL, NULL);	
   // Create the vector addition kernel
 	cl_kernel kernel;
	kernel = clCreateKernel(program, "vecadd", &status);
	//Associate the input and output buffers with kernel
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &bufA);
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &bufB);
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &bufC);
	//Define an index space
	size_t globalWorkSize[1];
	//Number of 'elements' = workItems
	globalWorkSize[0] = elements;
	//Execute the kernel
	status = clEnqueueNDRangeKernel(cmdQueue, kernel, 1, NULL, globalWorkSize, NULL, 0, NULL, NULL);
    //Copy result to host
	clEnqueueReadBuffer(cmdQueue, bufC, CL_TRUE, 0, datasize, C, 0, NULL, NULL);
	//Verify result
	int result = 1;
	for(int i = 0; i < elements; i++){
		if(C[i] != i+i){
			result = 0;
			break;
		}
		printf("\n %d + %d = %d", A[i], B[i], C[i]);
	}
	if(result == 0) {
		printf("\n Error! \n");
	}
	else {
		printf("\nNo Error! \n");
	}
	//Relase Resources
	clReleaseKernel(kernel);
	clReleaseProgram(program);
	clReleaseCommandQueue(cmdQueue);
	clReleaseMemObject(bufA);
	clReleaseMemObject(bufB);
	clReleaseMemObject(bufC);
	clReleaseContext(context);
	//Release Mem
	free(A);
	free(B);
	free(C);
	free(platforms);
	free(devices);
}
