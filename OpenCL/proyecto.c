#define CL_USE_DEPRECATED_OPENCL_1_2_APIS
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <CL/cl.h>


 const char* source = readSource("rotation.cl");
 cl_program program;


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

//host
 const char* sourceR, sourceEH, sourceEV;
 cl_program programR, programEH, programEV;
 int opt[2] = {0,0,0};
 char* actions[2] = {"Quiere rotar la imagen?", "Quiere espejar vertical. la imagen?", "Quiere espejar horiz. la imagen?"};
 char resp = '\0';
 for(int i = 0; i <= 2; i++){
 	printf("%s\n", actions[i]);
 	scanf("->%c", &resp);
 	if(resp == 'Y'){
 		opt[i] = 1;
 	}
 }
 int x0, y0, a;

 switch(opt){
  case opt[0] = 1:
   sourceR = readSource("rotation.cl");
   printf("Ingresar angulo ancho largo\n");
   scanf("%d %d %d", &a, &x0, &y0);
  case opt[1] = 1:
   sourceEV = readSource("espejarv.cl");
  case opt[2] = 1:
   sourceEH = readSource("espejarh.cl");
 }

 int imageHeight, imageWidth;
 float seno = sin(a);
 float coseno = cos(a);
 const char* inputFile = "input.bmp";
 float* inputImage = readImage(inputFile, &imageWidth, &imageHeight);
 int dataSize = imageHeight*imageWidth*sizeof(float);

 float* metadata = (float*)malloc(6*sizeof(float));
 float* outputImage = (float*)malloc(dataSize);

 metadata = {x0, y0, seno, coseno, imageWidth, imageHeight};

cl_mem buffImg;
cl_mem buffOut;
cl_mem buffMeta;

buffImg = clCreateBuffer(context, CL_MEM_READ_ONLY, dataSize, NULL, &status);
buffOut = clCreateBuffer(context, CL_MEM_READ_ONLY, dataSize, NULL, &status);
buffMeta = clCreateBuffer(context, CL_MEM_READ_ONLY, 4*sizeof(float), NULL, &status);

status = clEnqueueWriteBuffer(cmdQueue, buffImg, CL_FALSE, 0, dataSize, inputImage, 0, NULL, NULL);
status = clEnqueueWriteBuffer(cmdQueue, buffMeta, CL_FALSE, 0, 4*sizeof(float), metadata, 0, NULL, NULL);


// Create a program with source code
 cl_program program = clCreateProgramWithSource(context,1,(const char **)&source,NULL,&status);
 //build (compile) the program for the device
 status = clBuildProgram(program, numDevices, devices, NULL, NULL, NULL);
 // Create the vector addition kernel
 cl_kernel kernel;
 kernel = clCreateKernel(program, "rotation", &status);
 //Associate the input and output buffers with kernel
 status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffImg);
 status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffMeta);
 status = clSetKernelArg(kernel, 0, sizeof(cl_mem), &buffOut);
 //Define an index space
 size_t globalWorkSize[2];
 //Number of 'elements' = workItems
 globalWorkSize[0] = imageWidth*imageHeight;
	//Execute the kernel
	status = clEnqueueNDRangeKernel(cmdQueue, kernel, 1, NULL, globalWorkSize, NULL, 0, NULL, NULL);
    //Copy result to host
	clEnqueueReadBuffer(cmdQueue, bufC, CL_TRUE, 0, datasize, C, 0, NULL, NULL);
 //Relase Resources
	clReleaseKernel(kernel);
	clReleaseProgram(program);
	clReleaseCommandQueue(cmdQueue);
	clReleaseMemObject(buffImg);
	clReleaseMemObject(buffMeta);
	clReleaseMemObject(buffOut);
	clReleaseContext(context);
	//Release Mem
	free(metadata);
	free(outputImage);
	free(inputImage);
	free(platforms);
	free(devices);
}