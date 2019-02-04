%// This make.m is for MATLAB
%// Function: compile c++ files which rely on OpenCV for Matlab using mex
%// Author : zouxy
%// Date   : 2014-03-05
%// HomePage :  
%// Email  : 

%% Please modify your path of OpenCV
%% If your have any question, please contact Zou Xiaoyi

% Notice: first use "mex -setup" to choose your c/c++ compiler
clear all;

%-------------------------------------------------------------------
%% get the architecture of this computer
is_64bit = strcmp(computer,'MACI64') || strcmp(computer,'GLNXA64') || strcmp(computer,'PCWIN64');


%-------------------------------------------------------------------
%% the configuration of compiler
% You need to modify this configuration according to your own path of OpenCV
% Notice: if your system is 64bit, your OpenCV must be 64bit!
out_dir='./';
CPPFLAGS = ' -O -DNDEBUG -I/usr/local/opencv-3.2.0/include/opencv -I/usr/local/opencv-3.2.0/include -I/home/aalempij/git/mexopencv/include -I/home/aalempij/git/CudaSift_v2/include -I/usr/local/cuda-8.0/include/'  ; % your OpenCV "include" path
LDFLAGS = ' -L/usr/local/opencv-3.2.0/lib -L/home/aalempij/git/mexopencv/lib -L/home/aalempij/git/CudaSift_v2/build ';					   % your OpenCV "lib" path
LIBS = ' -lopencv_shape -lopencv_stitching -lopencv_objdetect -lopencv_superres -lopencv_videostab -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_video -lopencv_photo -lopencv_ml -lopencv_imgproc -lopencv_flann -lopencv_viz -lopencv_core -lMxArray -lcudaSift';
if is_64bit
	CPPFLAGS = [CPPFLAGS ' -largeArrayDims'];
end
%% add your files here!
compile_files = { 
	% the list of your code files which need to be compiled
	'mainSiftMex.cpp'
};


%-------------------------------------------------------------------
%% compiling...
for k = 1 : length(compile_files)
    str = compile_files{k};
    fprintf('compilation of: %s\n', str);
    str = [str ' -outdir ' out_dir CPPFLAGS LDFLAGS LIBS];
    args = regexp(str, '\s+', 'split');
    mex(args{:} );
end

fprintf('Congratulations, compilation successful!!!\n');
