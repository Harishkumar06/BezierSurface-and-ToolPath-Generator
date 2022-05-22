# Bezier Surface and Tool Path Generator
This program is built using matlab. What it does is it takes 4x12 matrix which contains the coordinates x,y and z so in other words 4x4 matrix data of points and builds the Bezier Surface from it. The code also generators an incremental (zig-zag) tool path and an adaptive tool based on the information feeded apart from the 4x4 points.

### Input Data
1. Points: 4x4 points in order to generate the Bezier Surface
2. Stock Height: If you were to machine a block of stock so that you can get the Bezier surface with the above mentioned points then the height of the stock which you plan to use.
3. Tool Tip radius: Similarily if you were to use a tool to machine the surface then th radius of the tool tip. <br>
**Note: The Tool is assumed to be ball ended.**
4. Scallop Height and Chordal Error: The code is bulit using Scallop height and chordal error as parameters to evaluate the surface finish. The following figure would help you understand about the Scallop height and Chordal Error better.
![Scallop Height vs Chordal error ](https://user-images.githubusercontent.com/59561786/169714550-6338fb27-6490-441f-b524-887dd72c7bd4.png )
### Output 
1. Beizer Surface: From the given 4x4 matrix.
2. Tool Path: A basic tool path to machine the earlier generated bezier surface considers the stock height but doesnt consider the scallop height or the chordal error or the tool tip radius.
3. Adaptive Tool Path: An adaptive toolpath generated to machine the same surface and takes all the given input data into account to give the required output.
4. NC Program: Generates a NC program to machine the earlier generated surface from the given matrix with the same surface finish (based on the feeded scallop height and chordal error) as a .txt file, with data on it.

Here's how the output would look like.
#### Bezier Surface, Tool Path, Adaptive Tool Path
![Output_new](https://user-images.githubusercontent.com/59561786/169715430-05ea221c-5ece-4e48-9999-e90d05b5111a.png)
#### NC Program
![image](https://user-images.githubusercontent.com/59561786/169715647-54cb9b28-36cb-4cc4-817e-ea266ea32a95.png)

